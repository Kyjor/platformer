# moving_positive means the fish is traveling upward (Y grows downward).

function update_fish(actor::Ptr{Actor}, dt::Float64)::Cvoid
    if actor.y >= actor.range_start && !actor.moving_positive
        actor.moving_positive = true
    elseif actor.y <= actor.range_end && actor.moving_positive
        actor.moving_positive = false
    end
    if actor.moving_positive
        actor.y -= actor.speed * dt
    else
        actor.y += actor.speed * dt
    end
    actor.anim += dt * Float64(5.0)
    if actor.anim >= Float64(2.0)
        actor.anim -= Float64(2.0)
    end
    return nothing
end

function fish_angle(actor::Ptr{Actor})::Float64
    if actor.moving_positive
        if actor.is_fire
            return Float64(0.0)
        end
        return Float64(90.0)
    end
    if actor.is_fire
        return Float64(180.0)
    end
    return Float64(270.0)
end
