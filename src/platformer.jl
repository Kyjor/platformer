# Platformer from julgame-platformer.
# Sprites: JuhoSprite, Super Mango, CC-BY 4.0.
# Scripts live in scripts/ and are called directly. There is no JulGame
# script list, so a scene update names the script instead of looking it up.
using StaticTools

include("../sdl/structs.jl")
include("../sdl/llvm_wrappers.jl")
include("../sdl/llvm_bindings.jl")
include("types.jl")
include("levels.jl")
include("math.jl")
include("sprites.jl")
include("draw.jl")
include("hud.jl")
include("scripts/easings.jl")
include("scripts/spider.jl")
include("scripts/fish.jl")
include("scripts/saw.jl")
include("scripts/player.jl")
include("scripts/game_manager.jl")
include("scene.jl")
include("scripts/background.jl")
include("scripts/water.jl")
include("scripts/title.jl")

function j_init_window()::Ptr{SDL_Window}
    llvm_SDL_Init(UInt32(SDL_INIT_VIDEO) + UInt32(SDL_INIT_AUDIO))
    title = c"Platformer"
    window::Ptr{SDL_Window} = GC.@preserve title llvm_SDL_CreateWindow(pointer(title), Int32(0), Int32(0), Int32(1280), Int32(720), UInt32(0))
    if window == Ptr{SDL_Window}(C_NULL)
        printf(c"Failed to create window\n")
    end
    return window
end

function j_init_renderer(window::Ptr{SDL_Window})::Ptr{SDL_Renderer}
    renderer::Ptr{SDL_Renderer} = llvm_SDL_CreateRenderer(window, Int32(-1), UInt32(SDL_RENDERER_ACCELERATED))
    if renderer == Ptr{SDL_Renderer}(C_NULL)
        printf(c"Failed to create renderer\n")
    end
    llvm_SDL_RenderSetScale(renderer, Float32(4.0), Float32(4.0))
    return renderer
end

function j_init_game_state(renderer::Ptr{SDL_Renderer}, window::Ptr{SDL_Window})::Ptr{Platformer}
    printf(c"Platformer — Enter to start, arrows or AD, space jumps\n")
    llvm_IMG_Init(Int32(2))
    if llvm_Mix_OpenAudio(Int32(44100), UInt16(0x8010), Int32(2), Int32(2048)) != Int32(0)
        printf(c"audio unavailable\n")
    end

    sprites::Ptr{SpriteBank} = Ptr{SpriteBank}(wasm_malloc(UInt32(sizeof(SpriteBank))))
    if load_sprite_bank(renderer, sprites) != Int32(0)
        return Ptr{Platformer}(C_NULL)
    end
    llvm_Mix_Init(Int32(8))
    jump_path = c"assets/sounds/jump.wav"
    jump_sound::Ptr{Mix_Chunk} = GC.@preserve jump_path llvm_Mix_LoadWAV(pointer(jump_path))
    coin_path = c"assets/sounds/coin.wav"
    coin_sound::Ptr{Mix_Chunk} = GC.@preserve coin_path llvm_Mix_LoadWAV(pointer(coin_path))
    if coin_sound != Ptr{Mix_Chunk}(C_NULL)
        llvm_Mix_VolumeChunk(coin_sound, Int32(50))
    end
    actors::Ptr{Actor} = Ptr{Actor}(wasm_malloc(UInt32(MAX_ACTORS) * UInt32(sizeof(Actor))))
    source_rect::Ptr{SDL_Rect} = Ptr{SDL_Rect}(wasm_malloc(UInt32(sizeof(SDL_Rect))))
    dest_rect::Ptr{SDL_Rect} = Ptr{SDL_Rect}(wasm_malloc(UInt32(sizeof(SDL_Rect))))
    event::Ptr{SDL_Event} = Ptr{SDL_Event}(wasm_malloc(UInt32(56)))
    state::Ptr{Platformer} = Ptr{Platformer}(wasm_malloc(UInt32(sizeof(Platformer))))
    unsafe_store!(state, Platformer(false, true, false, false, false, true, false, false, false, false, true, true, Int32(0), Int32(0), Int32(0), Int32(3), Int32(0), Int32(255), Int32(30), Int32(111), Int32(80), Int32(0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(-7.0), Float64(-3.0), Float64(0.4), Float64(0.0), Float64(2.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), llvm_SDL_GetPerformanceCounter(), actors, sprites, source_rect, dest_rect, event, jump_sound, coin_sound, Ptr{Mix_Music}(C_NULL)))
    return state
end

function game_loop(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, window::Ptr{SDL_Window})::Ptr{Platformer}
    current_time::UInt64 = llvm_SDL_GetPerformanceCounter()
    delta_time::Float64 = Float64(current_time - state.last_frame_time) / Float64(llvm_SDL_GetPerformanceFrequency())
    state.last_frame_time = current_time
    if delta_time > Float64(0.05)
        delta_time = Float64(0.05)
    end
    read_input(state)
    if state.on_title
        update_title(state)
        if !state.on_title
            draw_level(state, renderer)
        else
            draw_title(state, renderer)
        end
    else
        if !state.won
            update_player(state, delta_time)
            update_actors(state, delta_time)
            handle_actor_collisions(state)
            update_camera(state, delta_time)
        end
        draw_level(state, renderer)
    end
    if llvm_sc_is_web() == Int32(0)
        llvm_SDL_Delay(UInt32(16))
    end
    return state
end

function pc_main()::Int32
    window::Ptr{SDL_Window} = j_init_window()
    renderer::Ptr{SDL_Renderer} = j_init_renderer(window)
    state::Ptr{Platformer} = j_init_game_state(renderer, window)
    if state == Ptr{Platformer}(C_NULL)
        return Int32(1)
    end
    while !state.quit
        game_loop(state, renderer, window)
    end
    cleanup(state, renderer, window)
    return Int32(0)
end

function cleanup(state_ptr::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, window::Ptr{SDL_Window})::Cvoid
    if state_ptr.jump_sound != Ptr{Mix_Chunk}(C_NULL)
        llvm_Mix_FreeChunk(state_ptr.jump_sound)
    end
    if state_ptr.coin_sound != Ptr{Mix_Chunk}(C_NULL)
        llvm_Mix_FreeChunk(state_ptr.coin_sound)
    end
    if state_ptr.music != Ptr{Mix_Music}(C_NULL)
        llvm_Mix_HaltMusic()
        llvm_Mix_FreeMusic(state_ptr.music)
    end
    destroy_sprite_bank(state_ptr.sprites)
    wasm_free(Ptr{Cvoid}(state_ptr.sprites))
    wasm_free(Ptr{Cvoid}(state_ptr.actors))
    wasm_free(Ptr{Cvoid}(state_ptr.source_rect))
    wasm_free(Ptr{Cvoid}(state_ptr.dest_rect))
    wasm_free(Ptr{Cvoid}(state_ptr.event))
    wasm_free(Ptr{Cvoid}(state_ptr))
    llvm_SDL_DestroyRenderer(renderer)
    llvm_SDL_DestroyWindow(window)
    llvm_SDL_Quit()
    return nothing
end
