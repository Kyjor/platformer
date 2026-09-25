function abs_f(value::Float64)::Float64
    if value < Float64(0.0)
        return Float64(0.0) - value
    end
    return value
end

function sign_f(value::Float64)::Float64
    if value < Float64(0.0)
        return Float64(-1.0)
    end
    if value > Float64(0.0)
        return Float64(1.0)
    end
    return Float64(0.0)
end

function min_f(a::Float64, b::Float64)::Float64
    if a < b
        return a
    end
    return b
end

function floor_to_int(value::Float64)::Int32
    truncated::Int32 = unsafe_trunc(Int32, value)
    if Float64(truncated) > value
        return truncated - Int32(1)
    end
    return truncated
end

function boxes_overlap(ax::Float64, ay::Float64, aw::Float64, ah::Float64, bx::Float64, by::Float64, bw::Float64, bh::Float64)::Bool
    if ax + aw <= bx
        return false
    end
    if bx + bw <= ax
        return false
    end
    if ay + ah <= by
        return false
    end
    if by + bh <= ay
        return false
    end
    return true
end

function actor_at(actors::Ptr{Actor}, index::Int32)::Ptr{Actor}
    return actors + Int64(index) * Int64(sizeof(Actor))
end

function frame_index(time::Float64, frame_count::Int32)::Int32
    frame::Int32 = unsafe_trunc(Int32, time)
    if frame < Int32(0)
        return Int32(0)
    end
    if frame >= frame_count
        return frame_count - Int32(1)
    end
    return frame
end

function collision_at(level::Int32, tile_x::Int32, tile_y::Int32)::Int32
    col::Int32 = tile_x - level_origin_x(level)
    row::Int32 = tile_y - level_origin_y(level)
    width::Int32 = level_width(level)
    height::Int32 = level_height(level)
    if col < Int32(0) || row < Int32(0) || col >= width || row >= height
        return Int32(46)
    end
    cells::Ptr{UInt8} = level_collision(level)
    return Int32(unsafe_load(cells + Int64(row * width + col)))
end

function visual_at(level::Int32, tile_x::Int32, tile_y::Int32)::Int32
    col::Int32 = tile_x - level_origin_x(level)
    row::Int32 = tile_y - level_origin_y(level)
    width::Int32 = level_width(level)
    height::Int32 = level_height(level)
    if col < Int32(0) || row < Int32(0) || col >= width || row >= height
        return Int32(46)
    end
    cells::Ptr{UInt8} = level_visual(level)
    return Int32(unsafe_load(cells + Int64(row * width + col)))
end
