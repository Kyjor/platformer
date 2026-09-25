function update_spider(actor::Ptr{Actor}, dt::Float64)::Cvoid
    if actor.x <= actor.range_start && !actor.moving_positive
        actor.facing_right = false
        actor.moving_positive = true
    elseif actor.x >= actor.range_end && actor.moving_positive
        actor.facing_right = true
        actor.moving_positive = false
    end
    if actor.moving_positive
        actor.x += actor.speed * dt
    else
        actor.x -= actor.speed * dt
    end
    actor.anim += dt * Float64(4.0)
    if actor.anim >= Float64(3.0)
        actor.anim -= Float64(3.0)
    end
    return nothing
end
