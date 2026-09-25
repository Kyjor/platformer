function world_screen_x(state::Ptr{Platformer}, world_x::Float64)::Int32
    return unsafe_trunc(Int32, (world_x - (state.camera_x - VIEW_HALF_WIDTH)) * PIXELS_PER_UNIT)
end

function world_screen_y(state::Ptr{Platformer}, world_y::Float64)::Int32
    return unsafe_trunc(Int32, (world_y - (state.camera_y - VIEW_HALF_HEIGHT)) * PIXELS_PER_UNIT)
end

function blit_texture(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, texture::Ptr{SDL_Texture}, source_x::Int32, source_y::Int32, source_w::Int32, source_h::Int32, dest_x::Int32, dest_y::Int32, dest_w::Int32, dest_h::Int32, angle::Float64, flip::UInt32)::Cvoid
    if texture == Ptr{SDL_Texture}(C_NULL)
        return nothing
    end
    unsafe_store!(state.source_rect, SDL_Rect(source_x, source_y, source_w, source_h))
    unsafe_store!(state.dest_rect, SDL_Rect(dest_x, dest_y, dest_w, dest_h))
    llvm_SDL_RenderCopyEx(renderer, texture, state.source_rect, state.dest_rect, angle, Ptr{SDL_Point}(C_NULL), flip)
    return nothing
end

function fill_rect(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, x::Int32, y::Int32, w::Int32, h::Int32, red::Int32, green::Int32, blue::Int32, alpha::Int32)::Cvoid
    unsafe_store!(state.dest_rect, SDL_Rect(x, y, w, h))
    llvm_SDL_SetRenderDrawColor(renderer, UInt8(red), UInt8(green), UInt8(blue), UInt8(alpha))
    llvm_SDL_RenderFillRect(renderer, state.dest_rect)
    return nothing
end

function draw_tiles(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    first_x::Int32 = floor_to_int(state.camera_x - VIEW_HALF_WIDTH) - Int32(1)
    last_x::Int32 = floor_to_int(state.camera_x + VIEW_HALF_WIDTH) + Int32(1)
    first_y::Int32 = floor_to_int(state.camera_y - VIEW_HALF_HEIGHT) - Int32(1)
    last_y::Int32 = floor_to_int(state.camera_y + VIEW_HALF_HEIGHT) + Int32(1)
    tile_y::Int32 = first_y
    while tile_y <= last_y
        tile_x::Int32 = first_x
        while tile_x <= last_x
            code::Int32 = visual_at(state.level_index, tile_x, tile_y)
            if code != Int32(46)
                texture::Ptr{SDL_Texture} = bank_texture(state.sprites, level_tile_texture(code))
                source_w::Int32 = level_tile_src_w(code)
                source_h::Int32 = level_tile_src_h(code)
                blit_texture(state, renderer, texture, level_tile_src_x(code), level_tile_src_y(code), source_w, source_h, world_screen_x(state, Float64(tile_x)), world_screen_y(state, Float64(tile_y)), source_w, source_h, Float64(0.0), UInt32(0))
            end
            tile_x += Int32(1)
        end
        tile_y += Int32(1)
    end
    return nothing
end

function draw_actors(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    index::Int32 = Int32(0)
    while index < state.actor_count
        actor::Ptr{Actor} = actor_at(state.actors, index)
        if actor.alive
            texture::Ptr{SDL_Texture} = bank_texture(state.sprites, actor.sprite)
            dest_x::Int32 = world_screen_x(state, actor.x)
            dest_y::Int32 = world_screen_y(state, actor.y)
            if actor.kind == KIND_COIN || actor.kind == KIND_STAR
                blit_texture(state, renderer, texture, Int32(0), Int32(0), Int32(16), Int32(16), dest_x, dest_y, Int32(16), Int32(16), Float64(0.0), UInt32(0))
            elseif actor.kind == KIND_SPIDER
                frame::Int32 = frame_index(actor.anim, Int32(3))
                flip::UInt32 = UInt32(0)
                if !actor.facing_right
                    flip = UInt32(1)
                end
                blit_texture(state, renderer, texture, Int32(16) + frame * Int32(64), Int32(16), Int32(32), Int32(16), dest_x, dest_y, Int32(32), Int32(16), Float64(0.0), flip)
            elseif actor.kind == KIND_FISH
                fish_frame::Int32 = frame_index(actor.anim, Int32(2))
                blit_texture(state, renderer, texture, Int32(16) + fish_frame * Int32(48), Int32(13), Int32(16), Int32(19), dest_x, dest_y, Int32(16), Int32(19), fish_angle(actor), UInt32(0))
            elseif actor.kind == KIND_SAW
                blit_texture(state, renderer, texture, Int32(0), Int32(0), Int32(32), Int32(32), dest_x, dest_y, Int32(32), Int32(32), actor.rotation, UInt32(0))
            end
        end
        index += Int32(1)
    end
    return nothing
end

function draw_player_sprite(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    source_y::Int32 = Int32(16)
    frame_count::Int32 = Int32(4)
    if !state.grounded
        source_y = Int32(112)
        frame_count = Int32(2)
    elseif state.player_vx != Float64(0.0)
        source_y = Int32(64)
    end
    frame::Int32 = frame_index(state.player_anim, frame_count)
    flip::UInt32 = UInt32(0)
    if !state.facing_right
        flip = UInt32(1)
    end
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_PLAYER), Int32(16) + frame * Int32(48), source_y, Int32(16), Int32(16), world_screen_x(state, state.player_x), world_screen_y(state, state.player_y), Int32(16), Int32(16), Float64(0.0), flip)
    return nothing
end
