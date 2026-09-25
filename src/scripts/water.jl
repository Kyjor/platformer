# Layer 2 water, lava, and clouds sit in front of the level and stay with the camera.
# Frames are the reference animator: 16 fps, crops at x = 16 + frame * 48.

function fluid_frame()::Int32
    seconds::Float64 = Float64(llvm_SDL_GetPerformanceCounter()) / Float64(llvm_SDL_GetPerformanceFrequency())
    cycles::Int64 = unsafe_trunc(Int64, seconds * Float64(2.0))
    frame::Int32 = unsafe_trunc(Int32, seconds * Float64(16.0) - Float64(cycles) * Float64(8.0))
    if frame < Int32(0)
        frame = Int32(0)
    end
    if frame > Int32(7)
        frame = Int32(7)
    end
    return frame
end

function draw_fluid(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    texture_id::Int32 = level_fluid(state.level_index)
    if texture_id < Int32(0)
        return nothing
    end
    texture::Ptr{SDL_Texture} = bank_texture(state.sprites, texture_id)
    source_x::Int32 = Int32(16) + fluid_frame() * Int32(48)
    slot::Int32 = Int32(-12)
    while slot <= Int32(10)
        dest_x::Int32 = (slot + Int32(9)) * Int32(16)
        blit_texture(state, renderer, texture, source_x, Int32(16), Int32(16), Int32(32), dest_x, Int32(148), Int32(16), Int32(32), Float64(0.0), UInt32(0))
        slot += Int32(1)
    end
    return nothing
end
