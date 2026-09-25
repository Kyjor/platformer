function glyph_row(character::Int32, row::Int32)::Int32
    if character == Int32(48)
        if row == Int32(0)
            return Int32(14)
        elseif row == Int32(1) || row == Int32(2) || row == Int32(3) || row == Int32(4) || row == Int32(5)
            return Int32(17)
        end
        return Int32(14)
    elseif character == Int32(49)
        if row == Int32(0)
            return Int32(4)
        elseif row == Int32(1)
            return Int32(12)
        elseif row == Int32(6)
            return Int32(14)
        end
        return Int32(4)
    elseif character == Int32(50)
        if row == Int32(0) || row == Int32(3)
            return Int32(14)
        elseif row == Int32(1)
            return Int32(17)
        elseif row == Int32(2)
            return Int32(2)
        elseif row == Int32(4)
            return Int32(8)
        elseif row == Int32(5)
            return Int32(16)
        end
        return Int32(31)
    elseif character == Int32(51)
        if row == Int32(0) || row == Int32(3) || row == Int32(6)
            return Int32(14)
        elseif row == Int32(1) || row == Int32(2) || row == Int32(4) || row == Int32(5)
            return Int32(1)
        end
        return Int32(0)
    elseif character == Int32(52)
        if row == Int32(0)
            return Int32(2)
        elseif row == Int32(1)
            return Int32(6)
        elseif row == Int32(2)
            return Int32(10)
        elseif row == Int32(3)
            return Int32(18)
        elseif row == Int32(4)
            return Int32(31)
        end
        return Int32(2)
    elseif character == Int32(53)
        if row == Int32(0) || row == Int32(1)
            return Int32(31)
        elseif row == Int32(2)
            return Int32(16)
        elseif row == Int32(3)
            return Int32(30)
        elseif row == Int32(4) || row == Int32(5)
            return Int32(1)
        end
        return Int32(30)
    elseif character == Int32(54)
        if row == Int32(0)
            return Int32(14)
        elseif row == Int32(1) || row == Int32(2)
            return Int32(16)
        elseif row == Int32(3) || row == Int32(6)
            return Int32(30)
        end
        return Int32(17)
    elseif character == Int32(55)
        if row == Int32(0)
            return Int32(31)
        elseif row == Int32(1)
            return Int32(1)
        elseif row == Int32(2)
            return Int32(2)
        end
        return Int32(4)
    elseif character == Int32(56)
        if row == Int32(0) || row == Int32(3) || row == Int32(6)
            return Int32(14)
        end
        return Int32(17)
    elseif character == Int32(57)
        if row == Int32(0)
            return Int32(14)
        elseif row == Int32(1) || row == Int32(2)
            return Int32(17)
        elseif row == Int32(3)
            return Int32(15)
        elseif row == Int32(6)
            return Int32(14)
        end
        return Int32(1)
    elseif character == Int32(47)
        if row == Int32(1)
            return Int32(1)
        elseif row == Int32(2)
            return Int32(2)
        elseif row == Int32(3)
            return Int32(4)
        elseif row == Int32(4)
            return Int32(8)
        elseif row == Int32(5)
            return Int32(16)
        end
        return Int32(0)
    elseif character == Int32(89)
        if row == Int32(0)
            return Int32(17)
        elseif row == Int32(1)
            return Int32(10)
        end
        return Int32(4)
    elseif character == Int32(79)
        if row == Int32(0) || row == Int32(6)
            return Int32(14)
        end
        return Int32(17)
    elseif character == Int32(85)
        if row == Int32(6)
            return Int32(14)
        end
        return Int32(17)
    elseif character == Int32(87)
        if row == Int32(4)
            return Int32(21)
        elseif row == Int32(5) || row == Int32(6)
            return Int32(10)
        end
        return Int32(17)
    elseif character == Int32(73)
        if row == Int32(0) || row == Int32(6)
            return Int32(14)
        end
        return Int32(4)
    elseif character == Int32(78)
        if row == Int32(1)
            return Int32(25)
        elseif row == Int32(2)
            return Int32(21)
        elseif row == Int32(3)
            return Int32(19)
        end
        return Int32(17)
    elseif character == Int32(69)
        if row == Int32(0) || row == Int32(3) || row == Int32(6)
            return Int32(31)
        end
        return Int32(16)
    elseif character == Int32(82)
        if row == Int32(0) || row == Int32(3)
            return Int32(30)
        elseif row == Int32(4)
            return Int32(20)
        elseif row == Int32(5)
            return Int32(18)
        elseif row == Int32(6)
            return Int32(17)
        end
        return Int32(17)
    elseif character == Int32(84)
        if row == Int32(0)
            return Int32(31)
        end
        return Int32(4)
    elseif character == Int32(32)
        return Int32(0)
    end
    return Int32(0)
end

function draw_glyph(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, character::Int32, x::Int32, y::Int32, scale::Int32, red::Int32, green::Int32, blue::Int32, alpha::Int32)::Cvoid
    row::Int32 = Int32(0)
    while row < Int32(7)
        bits::Int32 = glyph_row(character, row)
        column::Int32 = Int32(0)
        while column < Int32(5)
            mask::Int32 = Int32(1) << (Int32(4) - column)
            if (bits & mask) != Int32(0)
                fill_rect(state, renderer, x + column * scale, y + row * scale, scale, scale, red, green, blue, alpha)
            end
            column += Int32(1)
        end
        row += Int32(1)
    end
    return nothing
end

function draw_text(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, text::Ptr{UInt8}, length::Int32, x::Int32, y::Int32, scale::Int32, red::Int32, green::Int32, blue::Int32, alpha::Int32)::Cvoid
    index::Int32 = Int32(0)
    cursor::Int32 = x
    while index < length
        character::Int32 = Int32(unsafe_load(text + Int64(index)))
        draw_glyph(state, renderer, character, cursor, y, scale, red, green, blue, alpha)
        cursor += Int32(6) * scale
        index += Int32(1)
    end
    return nothing
end

function draw_number(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer}, value::Int32, x::Int32, y::Int32)::Int32
    tens::Int32 = Int32(0)
    ones::Int32 = value
    if ones < Int32(0)
        ones = Int32(0)
    end
    while ones >= Int32(10)
        ones -= Int32(10)
        tens += Int32(1)
    end
    cursor::Int32 = x
    if tens > Int32(0)
        draw_glyph(state, renderer, Int32(48) + tens, cursor, y, Int32(2), Int32(255), Int32(255), Int32(255), Int32(255))
        cursor += Int32(12)
    end
    draw_glyph(state, renderer, Int32(48) + ones, cursor, y, Int32(2), Int32(255), Int32(255), Int32(255), Int32(255))
    return cursor + Int32(12)
end

function draw_hud(state::Ptr{Platformer}, renderer::Ptr{SDL_Renderer})::Cvoid
    blit_texture(state, renderer, bank_texture(state.sprites, TEX_COINS_ICON), Int32(0), Int32(0), Int32(16), Int32(16), Int32(8), Int32(28), Int32(16), Int32(16), Float64(0.0), UInt32(0))
    after_coins::Int32 = draw_number(state, renderer, state.coins_collected, Int32(28), Int32(30))
    draw_glyph(state, renderer, Int32(47), after_coins, Int32(30), Int32(2), Int32(255), Int32(255), Int32(255), Int32(255))
    draw_number(state, renderer, state.coin_total, after_coins + Int32(12), Int32(30))

    blit_texture(state, renderer, bank_texture(state.sprites, TEX_STARS_ICON), Int32(0), Int32(0), Int32(16), Int32(16), Int32(8), Int32(8), Int32(16), Int32(16), Float64(0.0), UInt32(0))
    draw_number(state, renderer, state.star_count, Int32(28), Int32(10))
    if state.won
        win_text = c"YOU WIN"
        GC.@preserve win_text draw_text(state, renderer, pointer(win_text), Int32(7), Int32(96), Int32(78), Int32(3), Int32(0), Int32(0), Int32(0), Int32(255))
    end
    return nothing
end
