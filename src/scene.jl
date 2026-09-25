function load_level(state::Ptr{Platformer}, level::Int32)::Cvoid
    state.level_index = level
    state.won = false
    state.coins_collected = Int32(0)
    state.coin_total = level_coin_total(level)
    state.deaths_this_level = Int32(0)
    state.player_x = level_player_x(level)
    state.player_y = level_player_y(level)
    state.spawn_x = state.player_x
    state.spawn_y = state.player_y
    state.player_vx = Float64(0.0)
    state.player_vy = Float64(0.0)
    state.jump_velocity = level_jump_velocity(level)
    state.grounded = false
    state.facing_right = true
    state.jump_released = true
    state.player_anim = Float64(0.0)
    state.camera_x = state.player_x
    state.camera_y = Float64(2.0)
    state.camera_target_x = state.player_x
    state.camera_velocity = Float64(0.0)
    state.last_player_x = state.player_x
    prepare_level_presentation(state)
    play_level_music(state)

    count::Int32 = level_actor_count(level)
    if count > MAX_ACTORS
        count = MAX_ACTORS
    end
    state.actor_count = count
    index::Int32 = Int32(0)
    while index < count
        level_spawn_actor(level, index, actor_at(state.actors, index))
        index += Int32(1)
    end
    return nothing
end

function read_input(state::Ptr{Platformer})::Cvoid
    state.jump_pressed = false
    state.enter_pressed = false
    event::Ptr{SDL_Event} = state.event
    while llvm_SDL_PollEvent(event) != Int32(0)
        if event.type == SDL_QUIT
            state.quit = true
        elseif event.type == SDL_KEYDOWN
            key::Int32 = event.key.keysym.sym
            if key == SDLK_ESCAPE
                state.quit = true
            elseif key == SDLK_LEFT || key == SDLK_a
                state.move_left = true
            elseif key == SDLK_RIGHT || key == SDLK_d
                state.move_right = true
            elseif key == SDLK_SPACE
                state.jump_pressed = true
                state.jump_held = true
            elseif key == SDLK_RETURN
                state.enter_pressed = true
            end
        elseif event.type == SDL_KEYUP
            released::Int32 = event.key.keysym.sym
            if released == SDLK_LEFT || released == SDLK_a
                state.move_left = false
            elseif released == SDLK_RIGHT || released == SDLK_d
                state.move_right = false
            elseif released == SDLK_SPACE
                state.jump_held = false
            end
        end
    end
    return nothing
end

function update_actors(state::Ptr{Platformer}, dt::Float64)::Cvoid
    index::Int32 = Int32(0)
    while index < state.actor_count
        actor::Ptr{Actor} = actor_at(state.actors, index)
        if actor.alive
            if actor.kind == KIND_SPIDER
                update_spider(actor, dt)
            elseif actor.kind == KIND_FISH
                update_fish(actor, dt)
            elseif actor.kind == KIND_SAW
                update_saw(actor, dt)
            end
        end
        index += Int32(1)
    end
    return nothing
end

function draw_level(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    llvm_SDL_SetRenderDrawColor(renderer, UInt8(state.clear_red), UInt8(state.clear_green), UInt8(state.clear_blue), UInt8(255))
    llvm_SDL_RenderClear(renderer)
    llvm_SDL_SetRenderDrawBlendMode(renderer, UInt32(1))
    draw_backgrounds(state, renderer)
    draw_tiles(state, renderer)
    draw_actors(state, renderer)
    draw_player_sprite(state, renderer)
    draw_fluid(state, renderer)
    draw_hud(state, renderer)
    llvm_SDL_RenderPresent(renderer)
    return nothing
end
