using StaticTools
using StaticCompiler

include("src/platformer.jl")

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
    (pc_main, entry_sig(pc_main), "pc_main"),
]

for (func, types, name) in functions_to_compile
    println("Compiling $name...")
    StaticCompiler.generate_obj(func, types, output_dir, name, emit_llvm_only=false)
end

o_files = filter(f -> endswith(f, ".o"), readdir(output_dir, join=true))
if Sys.iswindows()
    run(`gcc $o_files host/pc_main.c -o build/game.exe -O2 -lSDL2_image -lSDL2_mixer -lSDL2`)
    println("build/game.exe")
elseif Sys.isapple()
    fw = get(ENV, "SDL_FRAMEWORK_PATH", "")
    if isempty(fw)
        error("SDL_FRAMEWORK_PATH is unset; run ci/macos/fetch-sdl.sh")
    end
    rpath = "-Wl,-rpath,@executable_path/../Frameworks"
    run(`cc $o_files host/pc_main.c -o build/game -O2 -F$fw -framework SDL2 -framework SDL2_image -framework SDL2_mixer $rpath`)
    println("build/game")
else
    rpath = "-Wl,--disable-new-dtags,-rpath," * raw"$ORIGIN"
    run(`gcc $o_files host/pc_main.c -lSDL2 -lSDL2main -lSDL2_image -lSDL2_mixer -lGL $rpath -o build/game -O2`)
    println("build/game")
end
