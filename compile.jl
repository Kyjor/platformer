using StaticTools
using StaticCompiler

include("src/platformer.jl")

build_type = lowercase(get(ARGS, 1, "desktop"))
if build_type != "web" && build_type != "desktop"
    error("Usage: julia compile.jl [web|desktop]")
end

output_dir = "build"
if !isdir(output_dir)
    mkdir(output_dir)
end

entry_sig(f) = Tuple(only(methods(f)).sig.parameters[2:end])
functions_to_compile = [
    (j_init_game_state, entry_sig(j_init_game_state), "j_init_game_state"),
    (j_init_window, entry_sig(j_init_window), "j_init_window"),
    (j_init_renderer, entry_sig(j_init_renderer), "j_init_renderer"),
    (game_loop, entry_sig(game_loop), "game_loop"),
    (cleanup, entry_sig(cleanup), "cleanup"),
]
if build_type == "desktop"
    push!(functions_to_compile, (pc_main, entry_sig(pc_main), "pc_main"))
end

# Julia's own object emitter uses the System V register order. On Windows that
# passes SDL the window width where it expects the title pointer. Clang
# recompiles the IR with the Windows calling convention.
for (func, types, name) in functions_to_compile
    println("Compiling $name...")
    StaticCompiler.generate_obj(func, types, output_dir, name; emit_llvm_only=(build_type == "web" || Sys.iswindows()))
end

if build_type == "web"
    ll_files = filter(f -> endswith(f, ".ll") && !endswith(f, "combined.ll"), readdir(output_dir, join=true))
    isempty(ll_files) && error("no LLVM IR files in $output_dir")
    combined_ll = joinpath(output_dir, "combined.ll")
    run(`llvm-link -S -o $combined_ll $ll_files`)
    ir = replace(read(combined_ll, String), r"target triple = \"[^\"]+\"" => "target triple = \"wasm32-unknown-emscripten\"")
    write(combined_ll, ir)
    js_out = joinpath(output_dir, "game.js")
    run(Cmd([
        "emcc", combined_ll, "sdl/sdl_module.c", "host/web_main.c",
        "-s", "USE_SDL=2",
        "-s", "USE_SDL_IMAGE=2",
        "-s", "SDL2_IMAGE_FORMATS=[\"png\"]",
        "-s", "USE_SDL_MIXER=2",
        "-s", "USE_OGG=1",
        "-s", "USE_WEBGL2=1",
        "-O2",
        "-s", "WASM=1",
        "-s", "EXPORTED_FUNCTIONS=['_main','_malloc','_free']",
        "-s", "EXPORTED_RUNTIME_METHODS=['ccall','cwrap']",
        "-s", "ALLOW_MEMORY_GROWTH=1",
        "-s", "INITIAL_MEMORY=33554432",
        "-s", "ALLOW_TABLE_GROWTH=1",
        "-s", "STACK_SIZE=1048576",
        "-s", "ENVIRONMENT=web",
        "-s", "NO_EXIT_RUNTIME=1",
        "-o", js_out,
        "--preload-file", "./assets",
        "--use-preload-plugins",
    ]))
    println(js_out)
elseif Sys.iswindows()
    o_files = String[]
    for (_, _, name) in functions_to_compile
        ll = joinpath(output_dir, "$name.ll")
        obj = joinpath(output_dir, "$name.o")
        run(`clang -c -O2 -Wno-override-module $ll -o $obj`)
        push!(o_files, obj)
    end
    run(`gcc $o_files host/pc_main.c -o build/game.exe -O2 -lSDL2_image -lSDL2_mixer -lSDL2`)
    println("build/game.exe")
elseif Sys.isapple()
    o_files = filter(f -> endswith(f, ".o"), readdir(output_dir, join=true))
    fw = get(ENV, "SDL_FRAMEWORK_PATH", "")
    if isempty(fw)
        error("SDL_FRAMEWORK_PATH is unset; run ci/macos/fetch-sdl.sh")
    end
    rpath = "-Wl,-rpath,@executable_path/../Frameworks"
    run(`cc $o_files host/pc_main.c -o build/game -O2 -F$fw -framework SDL2 -framework SDL2_image -framework SDL2_mixer $rpath`)
    println("build/game")
else
    o_files = filter(f -> endswith(f, ".o"), readdir(output_dir, join=true))
    rpath = "-Wl,--disable-new-dtags,-rpath," * raw"$ORIGIN"
    run(`gcc $o_files host/pc_main.c -lSDL2 -lSDL2main -lSDL2_image -lSDL2_mixer -lGL $rpath -o build/game -O2`)
    println("build/game")
end
