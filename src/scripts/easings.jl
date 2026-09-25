# Camera follow uses ease_out_cubic. The rest of the original catalog is unused
# by this game, and the trig easings need sin, cos, and sqrt.

function ease_out_cubic(amount::Float64)::Float64
    inverse::Float64 = Float64(1.0) - amount
    return Float64(1.0) - inverse * inverse * inverse
end
