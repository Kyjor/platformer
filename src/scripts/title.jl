function update_title(state::Ptr{Platformer})::Cvoid
    if state.title_fading_out
        state.title_alpha -= Int32(3)
        if state.title_alpha <= Int32(40)
            state.title_fading_out = false
        end
    else
        state.title_alpha += Int32(3)
        if state.title_alpha >= Int32(250)
            state.title_fading_out = true
        end
    end
    if state.enter_pressed
        state.enter_pressed = false
        state.on_title = false
        load_level(state, Int32(1))
    end
    return nothing
end

function draw_title(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    llvm_SDL_SetRenderDrawColor(renderer, UInt8(20), UInt8(24), UInt8(28), UInt8(255))
    llvm_SDL_RenderClear(renderer)
    forest::Ptr{SDL_Texture} = bank_texture(state.sprites, TEX_FOREST_BACKGROUND)
    blit_texture(state, renderer, forest, Int32(0), Int32(0), Int32(320), Int32(180), Int32(0), Int32(0), Int32(320), Int32(180), Float64(0.0), UInt32(0))
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_LOGO), Int32(0), Int32(0), Int32(64), Int32(48), Int32(96), Int32(18), Int32(128), Int32(72), Float64(0.0), UInt32(0))

    blit_texture(state, renderer, bank_texture(state.sprites, TEX_KEY_UP), Int32(0), Int32(0), Int32(100), Int32(100), Int32(228), Int32(96), Int32(28), Int32(28), Float64(0.0), UInt32(0))
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_KEY_LEFT), Int32(0), Int32(0), Int32(100), Int32(100), Int32(196), Int32(128), Int32(28), Int32(28), Float64(0.0), UInt32(0))
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_KEY_DOWN), Int32(0), Int32(0), Int32(100), Int32(100), Int32(228), Int32(128), Int32(28), Int32(28), Float64(0.0), UInt32(0))
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_KEY_RIGHT), Int32(0), Int32(0), Int32(100), Int32(100), Int32(260), Int32(128), Int32(28), Int32(28), Float64(0.0), UInt32(0))
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_KEY_SPACE), Int32(0), Int32(0), Int32(100), Int32(100), Int32(36), Int32(118), Int32(40), Int32(40), Float64(0.0), UInt32(0))

    enter_text = c"ENTER"
    GC.@preserve enter_text draw_text(state, renderer, pointer(enter_text), Int32(5), Int32(28), Int32(148), Int32(2), Int32(255), Int32(255), Int32(255), state.title_alpha)
    llvm_SDL_RenderPresent(renderer)
    return nothing
end
