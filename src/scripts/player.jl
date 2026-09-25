function play_jump_sound(state::Ptr{Platformer})::Cvoid
    if state.jump_sound != Ptr{Mix_Chunk}(C_NULL)
        llvm_Mix_PlayChannel(Int32(-1), state.jump_sound, Int32(0))
    end
    return nothing
end

function respawn_player(state::Ptr{Platformer})::Cvoid
    state.player_x = state.spawn_x
    state.player_y = state.spawn_y
    state.player_vx = Float64(0.0)
    state.player_vy = Float64(0.0)
    state.grounded = false
    state.facing_right = true
    if state.star_count > Int32(0)
        state.star_count -= Int32(1)
    end
    state.deaths_this_level += Int32(1)
    state.camera_x = state.spawn_x
    state.camera_target_x = state.spawn_x
    state.camera_velocity = Float64(0.0)
    state.last_player_x = state.spawn_x
    return nothing
end

function player_overlaps_solid(state::Ptr{Platformer}, x::Float64, y::Float64)::Bool
    left::Int32 = floor_to_int(x + Float64(0.001))
    right::Int32 = floor_to_int(x + PLAYER_HIT_W - Float64(0.001))
    top::Int32 = floor_to_int(y + Float64(0.001))
    bottom::Int32 = floor_to_int(y + PLAYER_HIT_H - Float64(0.001))
    tile_y::Int32 = top
    while tile_y <= bottom
        tile_x::Int32 = left
        while tile_x <= right
            if collision_at(state.level_index, tile_x, tile_y) == Int32(35)
                return true
            end
            tile_x += Int32(1)
        end
        tile_y += Int32(1)
    end
    return false
end

function move_player(state::Ptr{Platformer}, dt::Float64)::Cvoid
    state.player_x += state.player_vx * dt
    hit_x::Float64 = state.player_x
    hit_y::Float64 = state.player_y + PLAYER_HIT_Y
    if player_overlaps_solid(state, hit_x, hit_y)
        if state.player_vx > Float64(0.0)
            tile::Int32 = floor_to_int(hit_x + PLAYER_HIT_W - Float64(0.001))
            state.player_x = Float64(tile) - PLAYER_HIT_W
        else
            tile_left::Int32 = floor_to_int(hit_x + Float64(0.001))
            state.player_x = Float64(tile_left + Int32(1))
        end
        state.player_vx = Float64(0.0)
    end

    previous_feet::Float64 = state.player_y + PLAYER_HIT_Y + PLAYER_HIT_H
    state.player_y += state.player_vy * dt
    hit_x = state.player_x
    hit_y = state.player_y + PLAYER_HIT_Y
    state.grounded = false

    if state.player_vy < Float64(0.0)
        if player_overlaps_solid(state, hit_x, hit_y)
            tile_top::Int32 = floor_to_int(hit_y + Float64(0.001))
            state.player_y = Float64(tile_top + Int32(1)) - PLAYER_HIT_Y
            state.player_vy = Float64(0.0)
        end
    else
        feet_tile::Int32 = floor_to_int(hit_y + PLAYER_HIT_H - Float64(0.001))
        left::Int32 = floor_to_int(hit_x + Float64(0.001))
        right::Int32 = floor_to_int(hit_x + PLAYER_HIT_W - Float64(0.001))
        landed::Bool = false
        tile_x::Int32 = left
        while tile_x <= right
            kind::Int32 = collision_at(state.level_index, tile_x, feet_tile)
            tile_top_y::Float64 = Float64(feet_tile)
            if kind == Int32(35)
                landed = true
            elseif kind == Int32(61) && previous_feet <= tile_top_y + Float64(0.08)
                landed = true
            end
            tile_x += Int32(1)
        end
        if landed
            state.player_y = Float64(feet_tile) - PLAYER_HIT_H - PLAYER_HIT_Y
            state.player_vy = Float64(0.0)
            state.grounded = true
        end
    end
    return nothing
end

function update_camera(state::Ptr{Platformer}, dt::Float64)::Cvoid
    player_velocity::Float64 = Float64(0.0)
    if dt > Float64(0.0)
        player_velocity = (state.player_x - state.last_player_x) / dt
    end
    lookahead::Float64 = Float64(0.0)
    speed::Float64 = abs_f(player_velocity)
    if speed > Float64(0.1)
        lookahead = sign_f(player_velocity) * Float64(1.5) * min_f(speed / Float64(10.0), Float64(1.0))
    end
    state.camera_velocity += (lookahead - state.camera_velocity) * Float64(0.8) * dt
    ideal_x::Float64 = state.player_x + state.camera_velocity
    dead_half::Float64 = Float64(1.0)
    if ideal_x < state.camera_target_x - dead_half
        state.camera_target_x = ideal_x + dead_half
    elseif ideal_x > state.camera_target_x + dead_half
        state.camera_target_x = ideal_x - dead_half
    end
    lerp_amount::Float64 = min_f(dt * Float64(4.0), Float64(1.0))
    state.camera_x += (state.camera_target_x - state.camera_x) * ease_out_cubic(lerp_amount)
    state.camera_y = Float64(2.0)
    state.last_player_x = state.player_x
    return nothing
end

function update_player(state::Ptr{Platformer}, dt::Float64)::Cvoid
    state.player_vx = Float64(0.0)
    if state.move_left
        state.player_vx = -PLAYER_SPEED
        state.facing_right = false
    end
    if state.move_right
        state.player_vx = PLAYER_SPEED
        state.facing_right = true
    end

    if state.jump_pressed && state.grounded
        play_jump_sound(state)
        state.player_vy = state.jump_velocity
        state.grounded = false
        state.jump_released = false
    end
    state.jump_pressed = false

    if !state.jump_held && !state.jump_released && state.player_vy < state.min_jump_velocity
        state.player_vy = state.player_vy * state.jump_dampening
        state.jump_released = true
    end

    drag::Float64 = Float64(0.05) * state.player_vy * state.player_vy
    state.player_vy += (GRAVITY - drag) * dt
    move_player(state, dt)

    if state.grounded
        state.jump_released = true
    end
    if state.player_y > FALL_LIMIT
        respawn_player(state)
        return nothing
    end

    anim_fps::Float64 = Float64(6.0)
    anim_span::Float64 = Float64(4.0)
    if !state.grounded
        anim_fps = Float64(2.0)
        anim_span = Float64(2.0)
    elseif state.player_vx != Float64(0.0)
        anim_fps = Float64(10.0)
    end
    state.player_anim += dt * anim_fps
    if state.player_anim >= anim_span
        state.player_anim -= anim_span
    end
    if state.player_anim >= anim_span
        state.player_anim -= anim_span
    end
    return nothing
end

function handle_actor_collisions(state::Ptr{Platformer})::Cvoid
    player_x::Float64 = state.player_x
    player_y::Float64 = state.player_y + PLAYER_HIT_Y
    index::Int32 = Int32(0)
    while index < state.actor_count
        actor::Ptr{Actor} = actor_at(state.actors, index)
        if actor.alive
            if actor.kind == KIND_COIN || actor.kind == KIND_STAR
                if boxes_overlap(player_x, player_y, PLAYER_HIT_W, PLAYER_HIT_H, actor.x, actor.y, Float64(1.0), Float64(1.0))
                    actor.alive = false
                    if actor.kind == KIND_COIN
                        if state.coin_sound != Ptr{Mix_Chunk}(C_NULL)
                            llvm_Mix_PlayChannel(Int32(-1), state.coin_sound, Int32(0))
                        end
                        state.coins_collected += Int32(1)
                        if state.coins_collected >= state.coin_total
                            complete_level(state)
                            return nothing
                        end
                    else
                        state.star_count += Int32(1)
                    end
                end
            elseif actor.kind == KIND_SPIDER
                if boxes_overlap(player_x, player_y, PLAYER_HIT_W, PLAYER_HIT_H, actor.x + Float64(0.5), actor.y, Float64(1.0), Float64(1.0))
                    respawn_player(state)
                    return nothing
                end
            elseif actor.kind == KIND_FISH
                if boxes_overlap(player_x, player_y, PLAYER_HIT_W, PLAYER_HIT_H, actor.x, actor.y, Float64(1.0), Float64(1.0))
                    respawn_player(state)
                    return nothing
                end
            elseif actor.kind == KIND_SAW
                if boxes_overlap(player_x, player_y, PLAYER_HIT_W, PLAYER_HIT_H, actor.x + Float64(0.5), actor.y + Float64(0.5), Float64(1.5), Float64(1.5))
                    respawn_player(state)
                    return nothing
                end
            end
        end
        index += Int32(1)
    end
    return nothing
end
