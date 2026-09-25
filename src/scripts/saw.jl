# Patrol the two authored Y values. The scene stores them in either order.

function update_saw(actor::Ptr{Actor}, dt::Float64)::Cvoid
    top::Float64 = actor.range_start
    bottom::Float64 = actor.range_end
    if actor.range_start > actor.range_end
        top = actor.range_end
        bottom = actor.range_start
    end
    if actor.y <= top
        actor.moving_positive = true
    elseif actor.y >= bottom
        actor.moving_positive = false
    end
    if actor.moving_positive
        actor.y += actor.speed * dt
    else
        actor.y -= actor.speed * dt
    end
    actor.rotation += Float64(300.0) * dt
    if actor.rotation >= Float64(360.0)
        actor.rotation -= Float64(360.0)
    end
    return nothing
end
