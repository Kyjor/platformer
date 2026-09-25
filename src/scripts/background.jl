function draw_backgrounds(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    count::Int32 = level_background_count(state.level_index)
    index::Int32 = Int32(0)
    while index < count
        texture_id::Int32 = level_background_texture(state.level_index, index)
        texture::Ptr{SDL_Texture} = bank_texture(state.sprites, texture_id)
        blit_texture(state, renderer, texture, Int32(0), Int32(0), Int32(320), Int32(180), Int32(0), Int32(0), Int32(320), Int32(180), Float64(0.0), UInt32(0))
        index += Int32(1)
    end
    return nothing
end
