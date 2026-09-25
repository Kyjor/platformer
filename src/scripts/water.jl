# Layer 2 water, lava, and clouds sit in front of the level and stay with the camera.
# Each strip is the reference crop (16, 16, 16, 32) placed from slot -12 through 10.

function draw_fluid(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    texture_id::Int32 = level_fluid(state.level_index)
    if texture_id < Int32(0)
        return nothing
    end
    texture::Ptr{SDL_Texture} = bank_texture(state.sprites, texture_id)
    slot::Int32 = Int32(-12)
    while slot <= Int32(10)
        dest_x::Int32 = (slot + Int32(9)) * Int32(16)
        blit_texture(state, renderer, texture, Int32(16), Int32(16), Int32(16), Int32(32), dest_x, Int32(112), Int32(16), Int32(32), Float64(0.0), UInt32(0))
        slot += Int32(1)
    end
    return nothing
end
