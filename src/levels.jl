# Baked from Platformer/scenes/level_1.json, level_2.json, and level_3.json.
# Each cell is one world unit. '.' is empty. Collision '#' is solid and '=' is one-way.

function level_player_x(level::Int32)::Float64
    if level == Int32(1)
        return Float64(4.890625)
    end
    if level == Int32(2)
        return Float64(1.0)
    end
    if level == Int32(3)
        return Float64(1.0)
    end
    return Float64(1.0)
end

function level_player_y(level::Int32)::Float64
    if level == Int32(1)
        return Float64(2.5625)
    end
    if level == Int32(2)
        return Float64(3.0)
    end
    if level == Int32(3)
        return Float64(3.0)
    end
    return Float64(4.0)
end

function level_jump_velocity(level::Int32)::Float64
    if level == Int32(1)
        return Float64(-7.0)
    end
    if level == Int32(2)
        return Float64(-10.0)
    end
    if level == Int32(3)
        return Float64(-6.5)
    end
    return Float64(-7.0)
end

function level_origin_x(level::Int32)::Int32
    if level == Int32(1)
        return Int32(0)
    end
    if level == Int32(2)
        return Int32(0)
    end
    if level == Int32(3)
        return Int32(0)
    end
    return Int32(0)
end

function level_origin_y(level::Int32)::Int32
    if level == Int32(1)
        return Int32(0)
    end
    if level == Int32(2)
        return Int32(1)
    end
    if level == Int32(3)
        return Int32(0)
    end
    return Int32(0)
end

function level_width(level::Int32)::Int32
    if level == Int32(1)
        return Int32(77)
    end
    if level == Int32(2)
        return Int32(77)
    end
    if level == Int32(3)
        return Int32(73)
    end
    return Int32(0)
end

function level_height(level::Int32)::Int32
    if level == Int32(1)
        return Int32(8)
    end
    if level == Int32(2)
        return Int32(7)
    end
    if level == Int32(3)
        return Int32(8)
    end
    return Int32(0)
end

function level_coin_total(level::Int32)::Int32
    if level == Int32(1)
        return Int32(18)
    end
    if level == Int32(2)
        return Int32(17)
    end
    if level == Int32(3)
        return Int32(17)
    end
    return Int32(0)
end

function level_fluid(level::Int32)::Int32
    if level == Int32(1)
        return Int32(9)
    end
    if level == Int32(2)
        return Int32(10)
    end
    if level == Int32(3)
        return Int32(11)
    end
    return Int32(-1)
end

function level_background_count(level::Int32)::Int32
    if level == Int32(1)
        return Int32(1)
    end
    if level == Int32(2)
        return Int32(1)
    end
    if level == Int32(3)
        return Int32(3)
    end
    return Int32(0)
end

function level_background_texture(level::Int32, index::Int32)::Int32
    if level == Int32(1) && index == Int32(0)
        return Int32(12)
    end
    if level == Int32(2) && index == Int32(0)
        return Int32(13)
    end
    if level == Int32(3) && index == Int32(0)
        return Int32(14)
    end
    if level == Int32(3) && index == Int32(1)
        return Int32(15)
    end
    if level == Int32(3) && index == Int32(2)
        return Int32(16)
    end
    return Int32(-1)
end

@inline function level_1_visual()::Ptr{UInt8}
    s = c"..........ACCG.........................................................................FDDH.........................................................................FDACCG..........ACCG..........................ACCCGEEEEACCCG..............ACCGDFDDH..........FDDH.ACCG...............ACCG..FDDDH....FDDDH..............FDDHDFDDH..........FDDH.FDDH...............FDDH..FDDDH....FDDDACCG....JCCCCCCCCCCCCCCCCCCCKEEJCCCCCCCCCCCCCCCCCCCKEEEEJCCCCCCCCCCCK....JCCCCCCCCCCKBDDDDDDDDDDDDDDDDDDDI..BDDDDDDDDDDDDDDDDDDDI....BDDDDDDDDDDDI....BDDDDDDDDDDIBDDDDDDDDDDDDDDDDDDDI..BDDDDDDDDDDDDDDDDDDDI....BDDDDDDDDDDDI....BDDDDDDDDDDI"
    return GC.@preserve s pointer(s)
end

@inline function level_1_collision()::Ptr{UInt8}
    s = c"..........====........................................................................................................................................................====..........====..........................=====####=====..............====....................====...............====.............................................................................................===....#############################################################....#############......................#........................#................#...........#......................#........................#................#..........."
    return GC.@preserve s pointer(s)
end

@inline function level_2_visual()::Ptr{UInt8}
    s = c"..........LNNNNQ.......................................................................POOOOR......................LNNQ..............LNNNQEEEELNNNQ..............LNNQOOOOR...............LNNQ...POOR........LNNQ..POOOR....POOOR..............POOROOOOR...............POOR...POOR........POOR..POOOR....POOOR.......TNNNNNNNNNNNNNNUE....EETNNNNNNNNNNNNNNNNNNNUEEEETNNNNNNNNNNNU....TNNNNNNNNNNUMOOOOOOOOOOOOOOS.......MOOOOOOOOOOOOOOOOOOOS....MOOOOOOOOOOOS....MOOOOOOOOOOSMOOOOOOOOOOOOOOS.......MOOOOOOOOOOOOOOOOOOOS....MOOOOOOOOOOOS....MOOOOOOOOOOS"
    return GC.@preserve s pointer(s)
end

@inline function level_2_collision()::Ptr{UInt8}
    s = c"..........======...................................................................................................====..............=====####=====..............====....................====...............====....................................................................................................#################....########################################....#############......................#........................#................#...........#......................#........................#................#..........."
    return GC.@preserve s pointer(s)
end

@inline function level_3_visual()::Ptr{UInt8}
    s = c"..........VXXa.....................................................................ZYYb.....................................................................ZYVXXa........................................VXXXaEEEEVXXXa..........VXXaYZYYb.....E....dXXe....................VXXa..ZYYYb....ZYYYb..........ZYYbYZYYb......E...WYYc....de..............ZYYb..ZYYYb....ZYYYVXXadXXXXXXXXXXXXXXe..........gffh....gh....dXXeEEEEdXXXXe..dXXXe....dXXXXXXeWYYYYYYYYYYYYYYc........................WYYc....WYYYYc..WYYYc....WYYYYYYcWYYYYYYYYYYYYYYc........................................................."
    return GC.@preserve s pointer(s)
end

@inline function level_3_collision()::Ptr{UInt8}
    s = c"..........====................................................................................................................................................====........................................=====####=====..........====..........#....====....................====.........................................#...........==..................................===################........................=############=..=####....#########...............................................#................#.......#........................................................................"
    return GC.@preserve s pointer(s)
end

function level_visual(level::Int32)::Ptr{UInt8}
    if level == Int32(1)
        return level_1_visual()
    end
    if level == Int32(2)
        return level_2_visual()
    end
    return level_3_visual()
end

function level_collision(level::Int32)::Ptr{UInt8}
    if level == Int32(1)
        return level_1_collision()
    end
    if level == Int32(2)
        return level_2_collision()
    end
    return level_3_collision()
end

function level_actor_count(level::Int32)::Int32
    if level == Int32(1)
        return Int32(32)
    end
    if level == Int32(2)
        return Int32(35)
    end
    if level == Int32(3)
        return Int32(30)
    end
    return Int32(0)
end

function level_spawn_actor(level::Int32, index::Int32, actor::Ptr{Actor})::Cvoid
    actor.alive = true
    actor.moving_positive = false
    actor.facing_right = true
    actor.is_fire = false
    actor.rotation = Float64(0.0)
    actor.anim = Float64(0.0)
    actor.speed = Float64(0.0)
    actor.range_start = Float64(0.0)
    actor.range_end = Float64(0.0)
    if level == Int32(1) && index == Int32(0)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(64.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(1)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(8.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(2)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(21.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(3)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(32.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(4)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(79.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(5)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(33.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(6)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(45.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(7)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(57.0)
        actor.y = Float64(3.9844)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(8)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(59.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(9)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(81.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(10)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(62.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(11)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(67.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(12)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(75.9688)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(13)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(47.0)
        actor.y = Float64(8.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(8.0)
        actor.range_end = Float64(3.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(14)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(1)
        actor.x = Float64(10.0)
        actor.y = Float64(-1.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(10.0)
        actor.range_end = Float64(13.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(15)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(1)
        actor.x = Float64(7.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(10.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(16)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(1)
        actor.x = Float64(56.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(56.0)
        actor.range_end = Float64(69.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(17)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(1)
        actor.x = Float64(30.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(30.0)
        actor.range_end = Float64(35.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(18)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(27.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(19)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(28.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(20)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(1)
        actor.x = Float64(26.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(26.0)
        actor.range_end = Float64(29.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(21)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(61.0)
        actor.y = Float64(6.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(6.0)
        actor.range_end = Float64(-2.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(22)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(21.0)
        actor.y = Float64(8.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(8.0)
        actor.range_end = Float64(2.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(23)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(22.0)
        actor.y = Float64(8.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(8.0)
        actor.range_end = Float64(2.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(24)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(44.0)
        actor.y = Float64(8.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(8.0)
        actor.range_end = Float64(3.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(25)
        actor.kind = KIND_FISH
        actor.sprite = Int32(3)
        actor.x = Float64(64.0)
        actor.y = Float64(6.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(6.0)
        actor.range_end = Float64(-2.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(26)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(52.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(27)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(14.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(28)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(4.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(29)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(11.0)
        actor.y = Float64(-2.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(30)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(63.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(1) && index == Int32(31)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(74.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(0)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(63.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(1)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(64.3438)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(2)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(8.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(3)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(14.0)
        actor.y = Float64(-1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(4)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(32.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(5)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(11.0)
        actor.y = Float64(-1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(6)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(33.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(7)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(45.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(8)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(58.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(9)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(59.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(10)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(78.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(11)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(66.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(12)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(62.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(13)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(68.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(14)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(74.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(15)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(47.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(16)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(8.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(8.0)
        actor.range_end = Float64(13.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(17)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(7.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(10.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(18)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(60.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(4.0)
        actor.range_start = Float64(60.0)
        actor.range_end = Float64(65.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(19)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(29.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(29.0)
        actor.range_end = Float64(36.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(20)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(41.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(21)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(38.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(22)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(31.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(1.0)
        actor.range_start = Float64(31.0)
        actor.range_end = Float64(34.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(23)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(61.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(24)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(16.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-1.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(25)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(18.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(26)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(44.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-1.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(27)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(64.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-1.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(28)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(52.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(29)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(21.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(1.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(30)
        actor.kind = KIND_FISH
        actor.sprite = Int32(4)
        actor.x = Float64(22.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(2) && index == Int32(31)
        actor.kind = KIND_SAW
        actor.sprite = Int32(8)
        actor.x = Float64(39.5)
        actor.y = Float64(0.0)
        actor.speed = Float64(5.0)
        actor.range_start = Float64(-1.0)
        actor.range_end = Float64(3.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(32)
        actor.kind = KIND_SAW
        actor.sprite = Int32(8)
        actor.x = Float64(57.5)
        actor.y = Float64(0.0)
        actor.speed = Float64(5.0)
        actor.range_start = Float64(-1.0)
        actor.range_end = Float64(3.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(33)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(40.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(2) && index == Int32(34)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(20.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(0)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(63.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(1)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(8.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(2)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(14.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(3)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(35.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(4)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(11.0)
        actor.y = Float64(-2.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(5)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(39.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(6)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(45.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(7)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(58.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(8)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(59.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(9)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(69.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(10)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(66.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(11)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(62.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(12)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(67.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(13)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(72.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(14)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(47.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(15)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(10.0)
        actor.y = Float64(-1.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(10.0)
        actor.range_end = Float64(13.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(16)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(7.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(10.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(17)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(56.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(56.0)
        actor.range_end = Float64(69.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(18)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(27.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(19)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(28.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(20)
        actor.kind = KIND_SPIDER
        actor.sprite = Int32(2)
        actor.x = Float64(27.0)
        actor.y = Float64(2.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(27.0)
        actor.range_end = Float64(28.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(21)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(61.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(4.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(22)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(21.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(23)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(22.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(3.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(24)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(44.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(2.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(25)
        actor.kind = KIND_FISH
        actor.sprite = Int32(5)
        actor.x = Float64(64.0)
        actor.y = Float64(7.0)
        actor.speed = Float64(4.0)
        actor.range_start = Float64(7.0)
        actor.range_end = Float64(-2.0)
        actor.is_fire = true
        return nothing
    end
    if level == Int32(3) && index == Int32(26)
        actor.kind = KIND_COIN
        actor.sprite = Int32(6)
        actor.x = Float64(52.0)
        actor.y = Float64(1.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(27)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(64.0)
        actor.y = Float64(3.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(28)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(28.0)
        actor.y = Float64(0.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    if level == Int32(3) && index == Int32(29)
        actor.kind = KIND_STAR
        actor.sprite = Int32(7)
        actor.x = Float64(44.0)
        actor.y = Float64(4.0)
        actor.speed = Float64(0.0)
        actor.range_start = Float64(0.0)
        actor.range_end = Float64(0.0)
        actor.is_fire = false
        return nothing
    end
    actor.alive = false
    actor.kind = KIND_NONE
    return nothing
end

function level_tile_texture(code::Int32)::Int32
    if code == Int32(65)
        return Int32(17)
    end
    if code == Int32(66)
        return Int32(18)
    end
    if code == Int32(67)
        return Int32(17)
    end
    if code == Int32(68)
        return Int32(17)
    end
    if code == Int32(69)
        return Int32(23)
    end
    if code == Int32(70)
        return Int32(17)
    end
    if code == Int32(71)
        return Int32(17)
    end
    if code == Int32(72)
        return Int32(17)
    end
    if code == Int32(73)
        return Int32(18)
    end
    if code == Int32(74)
        return Int32(18)
    end
    if code == Int32(75)
        return Int32(18)
    end
    if code == Int32(76)
        return Int32(19)
    end
    if code == Int32(77)
        return Int32(20)
    end
    if code == Int32(78)
        return Int32(19)
    end
    if code == Int32(79)
        return Int32(19)
    end
    if code == Int32(80)
        return Int32(19)
    end
    if code == Int32(81)
        return Int32(19)
    end
    if code == Int32(82)
        return Int32(19)
    end
    if code == Int32(83)
        return Int32(20)
    end
    if code == Int32(84)
        return Int32(20)
    end
    if code == Int32(85)
        return Int32(20)
    end
    if code == Int32(86)
        return Int32(21)
    end
    if code == Int32(87)
        return Int32(22)
    end
    if code == Int32(88)
        return Int32(21)
    end
    if code == Int32(89)
        return Int32(21)
    end
    if code == Int32(90)
        return Int32(21)
    end
    if code == Int32(97)
        return Int32(21)
    end
    if code == Int32(98)
        return Int32(21)
    end
    if code == Int32(99)
        return Int32(22)
    end
    if code == Int32(100)
        return Int32(22)
    end
    if code == Int32(101)
        return Int32(22)
    end
    if code == Int32(102)
        return Int32(22)
    end
    if code == Int32(103)
        return Int32(22)
    end
    if code == Int32(104)
        return Int32(22)
    end
    return Int32(-1)
end

function level_tile_src_x(code::Int32)::Int32
    if code == Int32(65)
        return Int32(0)
    end
    if code == Int32(66)
        return Int32(0)
    end
    if code == Int32(67)
        return Int32(16)
    end
    if code == Int32(68)
        return Int32(16)
    end
    if code == Int32(69)
        return Int32(0)
    end
    if code == Int32(70)
        return Int32(0)
    end
    if code == Int32(71)
        return Int32(32)
    end
    if code == Int32(72)
        return Int32(32)
    end
    if code == Int32(73)
        return Int32(32)
    end
    if code == Int32(74)
        return Int32(0)
    end
    if code == Int32(75)
        return Int32(32)
    end
    if code == Int32(76)
        return Int32(0)
    end
    if code == Int32(77)
        return Int32(0)
    end
    if code == Int32(78)
        return Int32(16)
    end
    if code == Int32(79)
        return Int32(16)
    end
    if code == Int32(80)
        return Int32(0)
    end
    if code == Int32(81)
        return Int32(32)
    end
    if code == Int32(82)
        return Int32(32)
    end
    if code == Int32(83)
        return Int32(32)
    end
    if code == Int32(84)
        return Int32(0)
    end
    if code == Int32(85)
        return Int32(32)
    end
    if code == Int32(86)
        return Int32(0)
    end
    if code == Int32(87)
        return Int32(0)
    end
    if code == Int32(88)
        return Int32(16)
    end
    if code == Int32(89)
        return Int32(16)
    end
    if code == Int32(90)
        return Int32(0)
    end
    if code == Int32(97)
        return Int32(32)
    end
    if code == Int32(98)
        return Int32(32)
    end
    if code == Int32(99)
        return Int32(32)
    end
    if code == Int32(100)
        return Int32(0)
    end
    if code == Int32(101)
        return Int32(32)
    end
    if code == Int32(102)
        return Int32(16)
    end
    if code == Int32(103)
        return Int32(0)
    end
    if code == Int32(104)
        return Int32(32)
    end
    return Int32(0)
end

function level_tile_src_y(code::Int32)::Int32
    if code == Int32(65)
        return Int32(0)
    end
    if code == Int32(66)
        return Int32(16)
    end
    if code == Int32(67)
        return Int32(0)
    end
    if code == Int32(68)
        return Int32(16)
    end
    if code == Int32(69)
        return Int32(0)
    end
    if code == Int32(70)
        return Int32(16)
    end
    if code == Int32(71)
        return Int32(0)
    end
    if code == Int32(72)
        return Int32(16)
    end
    if code == Int32(73)
        return Int32(16)
    end
    if code == Int32(74)
        return Int32(0)
    end
    if code == Int32(75)
        return Int32(0)
    end
    if code == Int32(76)
        return Int32(0)
    end
    if code == Int32(77)
        return Int32(16)
    end
    if code == Int32(78)
        return Int32(0)
    end
    if code == Int32(79)
        return Int32(16)
    end
    if code == Int32(80)
        return Int32(16)
    end
    if code == Int32(81)
        return Int32(0)
    end
    if code == Int32(82)
        return Int32(16)
    end
    if code == Int32(83)
        return Int32(16)
    end
    if code == Int32(84)
        return Int32(0)
    end
    if code == Int32(85)
        return Int32(0)
    end
    if code == Int32(86)
        return Int32(0)
    end
    if code == Int32(87)
        return Int32(16)
    end
    if code == Int32(88)
        return Int32(0)
    end
    if code == Int32(89)
        return Int32(16)
    end
    if code == Int32(90)
        return Int32(16)
    end
    if code == Int32(97)
        return Int32(0)
    end
    if code == Int32(98)
        return Int32(16)
    end
    if code == Int32(99)
        return Int32(16)
    end
    if code == Int32(100)
        return Int32(0)
    end
    if code == Int32(101)
        return Int32(0)
    end
    if code == Int32(102)
        return Int32(32)
    end
    if code == Int32(103)
        return Int32(32)
    end
    if code == Int32(104)
        return Int32(32)
    end
    return Int32(0)
end

function level_tile_src_w(code::Int32)::Int32
    if code == Int32(65)
        return Int32(16)
    end
    if code == Int32(66)
        return Int32(16)
    end
    if code == Int32(67)
        return Int32(16)
    end
    if code == Int32(68)
        return Int32(16)
    end
    if code == Int32(69)
        return Int32(16)
    end
    if code == Int32(70)
        return Int32(16)
    end
    if code == Int32(71)
        return Int32(16)
    end
    if code == Int32(72)
        return Int32(16)
    end
    if code == Int32(73)
        return Int32(16)
    end
    if code == Int32(74)
        return Int32(16)
    end
    if code == Int32(75)
        return Int32(16)
    end
    if code == Int32(76)
        return Int32(16)
    end
    if code == Int32(77)
        return Int32(16)
    end
    if code == Int32(78)
        return Int32(16)
    end
    if code == Int32(79)
        return Int32(16)
    end
    if code == Int32(80)
        return Int32(16)
    end
    if code == Int32(81)
        return Int32(16)
    end
    if code == Int32(82)
        return Int32(16)
    end
    if code == Int32(83)
        return Int32(16)
    end
    if code == Int32(84)
        return Int32(16)
    end
    if code == Int32(85)
        return Int32(16)
    end
    if code == Int32(86)
        return Int32(16)
    end
    if code == Int32(87)
        return Int32(16)
    end
    if code == Int32(88)
        return Int32(16)
    end
    if code == Int32(89)
        return Int32(16)
    end
    if code == Int32(90)
        return Int32(16)
    end
    if code == Int32(97)
        return Int32(16)
    end
    if code == Int32(98)
        return Int32(16)
    end
    if code == Int32(99)
        return Int32(16)
    end
    if code == Int32(100)
        return Int32(16)
    end
    if code == Int32(101)
        return Int32(16)
    end
    if code == Int32(102)
        return Int32(16)
    end
    if code == Int32(103)
        return Int32(16)
    end
    if code == Int32(104)
        return Int32(16)
    end
    return Int32(16)
end

function level_tile_src_h(code::Int32)::Int32
    if code == Int32(65)
        return Int32(16)
    end
    if code == Int32(66)
        return Int32(16)
    end
    if code == Int32(67)
        return Int32(16)
    end
    if code == Int32(68)
        return Int32(16)
    end
    if code == Int32(69)
        return Int32(16)
    end
    if code == Int32(70)
        return Int32(16)
    end
    if code == Int32(71)
        return Int32(16)
    end
    if code == Int32(72)
        return Int32(16)
    end
    if code == Int32(73)
        return Int32(16)
    end
    if code == Int32(74)
        return Int32(16)
    end
    if code == Int32(75)
        return Int32(16)
    end
    if code == Int32(76)
        return Int32(16)
    end
    if code == Int32(77)
        return Int32(16)
    end
    if code == Int32(78)
        return Int32(16)
    end
    if code == Int32(79)
        return Int32(16)
    end
    if code == Int32(80)
        return Int32(16)
    end
    if code == Int32(81)
        return Int32(16)
    end
    if code == Int32(82)
        return Int32(16)
    end
    if code == Int32(83)
        return Int32(16)
    end
    if code == Int32(84)
        return Int32(16)
    end
    if code == Int32(85)
        return Int32(16)
    end
    if code == Int32(86)
        return Int32(16)
    end
    if code == Int32(87)
        return Int32(16)
    end
    if code == Int32(88)
        return Int32(16)
    end
    if code == Int32(89)
        return Int32(16)
    end
    if code == Int32(90)
        return Int32(16)
    end
    if code == Int32(97)
        return Int32(16)
    end
    if code == Int32(98)
        return Int32(16)
    end
    if code == Int32(99)
        return Int32(16)
    end
    if code == Int32(100)
        return Int32(16)
    end
    if code == Int32(101)
        return Int32(16)
    end
    if code == Int32(102)
        return Int32(16)
    end
    if code == Int32(103)
        return Int32(16)
    end
    if code == Int32(104)
        return Int32(16)
    end
    return Int32(16)
end

