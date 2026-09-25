# Concrete stand-ins for the JulGame scripts. There is no script array and no JSON
# loader: each script is a function in scripts/, and the scene calls it by kind.

const KIND_NONE::Int32 = Int32(0)
const KIND_COIN::Int32 = Int32(1)
const KIND_STAR::Int32 = Int32(2)
const KIND_SPIDER::Int32 = Int32(3)
const KIND_FISH::Int32 = Int32(4)
const KIND_SAW::Int32 = Int32(5)

const TEX_PLAYER::Int32 = Int32(0)
const TEX_SPIDER_FOREST::Int32 = Int32(1)
const TEX_SPIDER_CASTLE::Int32 = Int32(2)
const TEX_FISH::Int32 = Int32(3)
const TEX_FLAME_CASTLE::Int32 = Int32(4)
const TEX_FLAME_SKY::Int32 = Int32(5)
const TEX_COIN::Int32 = Int32(6)
const TEX_STAR::Int32 = Int32(7)
const TEX_SAW::Int32 = Int32(8)
const TEX_WATER::Int32 = Int32(9)
const TEX_LAVA::Int32 = Int32(10)
const TEX_CLOUDS::Int32 = Int32(11)
const TEX_FOREST_BACKGROUND::Int32 = Int32(12)
const TEX_CASTLE_BACKGROUND::Int32 = Int32(13)
const TEX_SKY_FAR::Int32 = Int32(14)
const TEX_SKY_MID::Int32 = Int32(15)
const TEX_SKY_NEAR::Int32 = Int32(16)
const TEX_GRASS_ONEWAY::Int32 = Int32(17)
const TEX_GRASS_TILESET::Int32 = Int32(18)
const TEX_BRICK_ONEWAY::Int32 = Int32(19)
const TEX_BRICK_TILESET::Int32 = Int32(20)
const TEX_ROCK_ONEWAY::Int32 = Int32(21)
const TEX_ROCK_TILESET::Int32 = Int32(22)
const TEX_BRIDGE::Int32 = Int32(23)
const TEX_STARS_ICON::Int32 = Int32(24)
const TEX_COINS_ICON::Int32 = Int32(25)
const TEX_LOGO::Int32 = Int32(26)
const TEX_KEY_SPACE::Int32 = Int32(27)
const TEX_KEY_UP::Int32 = Int32(28)
const TEX_KEY_DOWN::Int32 = Int32(29)
const TEX_KEY_LEFT::Int32 = Int32(30)
const TEX_KEY_RIGHT::Int32 = Int32(31)

const MAX_ACTORS::Int32 = Int32(40)
const VIEW_HALF_WIDTH::Float64 = Float64(10.0)
const VIEW_HALF_HEIGHT::Float64 = Float64(5.625)
const PIXELS_PER_UNIT::Float64 = Float64(16.0)
const GRAVITY::Float64 = Float64(9.81)
const PLAYER_SPEED::Float64 = Float64(5.0)
const PLAYER_HIT_Y::Float64 = Float64(0.125)
const PLAYER_HIT_W::Float64 = Float64(0.75)
const PLAYER_HIT_H::Float64 = Float64(0.75)
const FALL_LIMIT::Float64 = Float64(8.0)

struct Actor
    kind::Int32
    sprite::Int32
    alive::Bool
    moving_positive::Bool
    facing_right::Bool
    is_fire::Bool
    x::Float64
    y::Float64
    speed::Float64
    range_start::Float64
    range_end::Float64
    rotation::Float64
    anim::Float64
end

struct SpriteBank
    player::Ptr{SDL_Texture}
    spider_forest::Ptr{SDL_Texture}
    spider_castle::Ptr{SDL_Texture}
    fish::Ptr{SDL_Texture}
    flame_castle::Ptr{SDL_Texture}
    flame_sky::Ptr{SDL_Texture}
    coin::Ptr{SDL_Texture}
    star::Ptr{SDL_Texture}
    saw::Ptr{SDL_Texture}
    water::Ptr{SDL_Texture}
    lava::Ptr{SDL_Texture}
    clouds::Ptr{SDL_Texture}
    forest_background::Ptr{SDL_Texture}
    castle_background::Ptr{SDL_Texture}
    sky_far::Ptr{SDL_Texture}
    sky_mid::Ptr{SDL_Texture}
    sky_near::Ptr{SDL_Texture}
    grass_oneway::Ptr{SDL_Texture}
    grass_tileset::Ptr{SDL_Texture}
    brick_oneway::Ptr{SDL_Texture}
    brick_tileset::Ptr{SDL_Texture}
    rock_oneway::Ptr{SDL_Texture}
    rock_tileset::Ptr{SDL_Texture}
    bridge::Ptr{SDL_Texture}
    stars_icon::Ptr{SDL_Texture}
    coins_icon::Ptr{SDL_Texture}
    logo::Ptr{SDL_Texture}
    key_space::Ptr{SDL_Texture}
    key_up::Ptr{SDL_Texture}
    key_down::Ptr{SDL_Texture}
    key_left::Ptr{SDL_Texture}
    key_right::Ptr{SDL_Texture}
end

struct Platformer
    quit::Bool
    on_title::Bool
    won::Bool
    jump_held::Bool
    jump_pressed::Bool
    jump_released::Bool
    move_left::Bool
    move_right::Bool
    enter_pressed::Bool
    grounded::Bool
    facing_right::Bool
    title_fading_out::Bool
    level_index::Int32
    coins_collected::Int32
    coin_total::Int32
    star_count::Int32
    deaths_this_level::Int32
    title_alpha::Int32
    clear_red::Int32
    clear_green::Int32
    clear_blue::Int32
    actor_count::Int32
    player_x::Float64
    player_y::Float64
    player_vx::Float64
    player_vy::Float64
    spawn_x::Float64
    spawn_y::Float64
    jump_velocity::Float64
    min_jump_velocity::Float64
    jump_dampening::Float64
    camera_x::Float64
    camera_y::Float64
    camera_target_x::Float64
    camera_velocity::Float64
    last_player_x::Float64
    player_anim::Float64
    last_frame_time::UInt64
    actors::Ptr{Actor}
    sprites::Ptr{SpriteBank}
    source_rect::Ptr{SDL_Rect}
    dest_rect::Ptr{SDL_Rect}
    event::Ptr{SDL_Event}
    jump_sound::Ptr{Mix_Chunk}
    coin_sound::Ptr{Mix_Chunk}
    music::Ptr{Mix_Music}
end

function Base.pointer(p::Ptr{UInt8})::Ptr{UInt8}
    return p
end

@generated function offsetof(::Type{X}, ::Val{field}) where {X,field}
    idx = findfirst(f -> f == field, fieldnames(X))
    return fieldoffset(X, idx)
end

function Base.getproperty(x::Ptr{Actor}, f::Symbol)
    f === :kind && return unsafe_load(Ptr{Int32}(x + offsetof(Actor, Val(:kind))))
    f === :sprite && return unsafe_load(Ptr{Int32}(x + offsetof(Actor, Val(:sprite))))
    f === :alive && return unsafe_load(Ptr{Bool}(x + offsetof(Actor, Val(:alive))))
    f === :moving_positive && return unsafe_load(Ptr{Bool}(x + offsetof(Actor, Val(:moving_positive))))
    f === :facing_right && return unsafe_load(Ptr{Bool}(x + offsetof(Actor, Val(:facing_right))))
    f === :is_fire && return unsafe_load(Ptr{Bool}(x + offsetof(Actor, Val(:is_fire))))
    f === :x && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:x))))
    f === :y && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:y))))
    f === :speed && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:speed))))
    f === :range_start && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:range_start))))
    f === :range_end && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:range_end))))
    f === :rotation && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:rotation))))
    f === :anim && return unsafe_load(Ptr{Float64}(x + offsetof(Actor, Val(:anim))))
end

function Base.setproperty!(x::Ptr{Actor}, f::Symbol, v::Any)
    f === :kind && return unsafe_store!(Ptr{Int32}(x + offsetof(Actor, Val(:kind))), v)
    f === :sprite && return unsafe_store!(Ptr{Int32}(x + offsetof(Actor, Val(:sprite))), v)
    f === :alive && return unsafe_store!(Ptr{Bool}(x + offsetof(Actor, Val(:alive))), v)
    f === :moving_positive && return unsafe_store!(Ptr{Bool}(x + offsetof(Actor, Val(:moving_positive))), v)
    f === :facing_right && return unsafe_store!(Ptr{Bool}(x + offsetof(Actor, Val(:facing_right))), v)
    f === :is_fire && return unsafe_store!(Ptr{Bool}(x + offsetof(Actor, Val(:is_fire))), v)
    f === :x && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:x))), v)
    f === :y && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:y))), v)
    f === :speed && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:speed))), v)
    f === :range_start && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:range_start))), v)
    f === :range_end && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:range_end))), v)
    f === :rotation && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:rotation))), v)
    f === :anim && return unsafe_store!(Ptr{Float64}(x + offsetof(Actor, Val(:anim))), v)
end

function Base.getproperty(x::Ptr{SpriteBank}, f::Symbol)
    f === :player && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:player))))
    f === :spider_forest && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:spider_forest))))
    f === :spider_castle && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:spider_castle))))
    f === :fish && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:fish))))
    f === :flame_castle && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:flame_castle))))
    f === :flame_sky && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:flame_sky))))
    f === :coin && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:coin))))
    f === :star && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:star))))
    f === :saw && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:saw))))
    f === :water && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:water))))
    f === :lava && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:lava))))
    f === :clouds && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:clouds))))
    f === :forest_background && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:forest_background))))
    f === :castle_background && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:castle_background))))
    f === :sky_far && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_far))))
    f === :sky_mid && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_mid))))
    f === :sky_near && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_near))))
    f === :grass_oneway && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:grass_oneway))))
    f === :grass_tileset && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:grass_tileset))))
    f === :brick_oneway && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:brick_oneway))))
    f === :brick_tileset && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:brick_tileset))))
    f === :rock_oneway && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:rock_oneway))))
    f === :rock_tileset && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:rock_tileset))))
    f === :bridge && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:bridge))))
    f === :stars_icon && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:stars_icon))))
    f === :coins_icon && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:coins_icon))))
    f === :logo && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:logo))))
    f === :key_space && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_space))))
    f === :key_up && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_up))))
    f === :key_down && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_down))))
    f === :key_left && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_left))))
    f === :key_right && return unsafe_load(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_right))))
end

function Base.setproperty!(x::Ptr{SpriteBank}, f::Symbol, v::Any)
    f === :player && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:player))), v)
    f === :spider_forest && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:spider_forest))), v)
    f === :spider_castle && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:spider_castle))), v)
    f === :fish && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:fish))), v)
    f === :flame_castle && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:flame_castle))), v)
    f === :flame_sky && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:flame_sky))), v)
    f === :coin && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:coin))), v)
    f === :star && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:star))), v)
    f === :saw && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:saw))), v)
    f === :water && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:water))), v)
    f === :lava && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:lava))), v)
    f === :clouds && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:clouds))), v)
    f === :forest_background && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:forest_background))), v)
    f === :castle_background && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:castle_background))), v)
    f === :sky_far && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_far))), v)
    f === :sky_mid && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_mid))), v)
    f === :sky_near && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:sky_near))), v)
    f === :grass_oneway && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:grass_oneway))), v)
    f === :grass_tileset && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:grass_tileset))), v)
    f === :brick_oneway && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:brick_oneway))), v)
    f === :brick_tileset && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:brick_tileset))), v)
    f === :rock_oneway && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:rock_oneway))), v)
    f === :rock_tileset && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:rock_tileset))), v)
    f === :bridge && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:bridge))), v)
    f === :stars_icon && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:stars_icon))), v)
    f === :coins_icon && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:coins_icon))), v)
    f === :logo && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:logo))), v)
    f === :key_space && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_space))), v)
    f === :key_up && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_up))), v)
    f === :key_down && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_down))), v)
    f === :key_left && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_left))), v)
    f === :key_right && return unsafe_store!(Ptr{Ptr{SDL_Texture}}(x + offsetof(SpriteBank, Val(:key_right))), v)
end

function Base.getproperty(x::Ptr{Platformer}, f::Symbol)
    f === :quit && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:quit))))
    f === :on_title && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:on_title))))
    f === :won && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:won))))
    f === :jump_held && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_held))))
    f === :jump_pressed && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_pressed))))
    f === :jump_released && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_released))))
    f === :move_left && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:move_left))))
    f === :move_right && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:move_right))))
    f === :enter_pressed && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:enter_pressed))))
    f === :grounded && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:grounded))))
    f === :facing_right && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:facing_right))))
    f === :title_fading_out && return unsafe_load(Ptr{Bool}(x + offsetof(Platformer, Val(:title_fading_out))))
    f === :level_index && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:level_index))))
    f === :coins_collected && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:coins_collected))))
    f === :coin_total && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:coin_total))))
    f === :star_count && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:star_count))))
    f === :deaths_this_level && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:deaths_this_level))))
    f === :title_alpha && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:title_alpha))))
    f === :clear_red && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_red))))
    f === :clear_green && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_green))))
    f === :clear_blue && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_blue))))
    f === :actor_count && return unsafe_load(Ptr{Int32}(x + offsetof(Platformer, Val(:actor_count))))
    f === :player_x && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:player_x))))
    f === :player_y && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:player_y))))
    f === :player_vx && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:player_vx))))
    f === :player_vy && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:player_vy))))
    f === :spawn_x && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:spawn_x))))
    f === :spawn_y && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:spawn_y))))
    f === :jump_velocity && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:jump_velocity))))
    f === :min_jump_velocity && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:min_jump_velocity))))
    f === :jump_dampening && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:jump_dampening))))
    f === :camera_x && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_x))))
    f === :camera_y && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_y))))
    f === :camera_target_x && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_target_x))))
    f === :camera_velocity && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_velocity))))
    f === :last_player_x && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:last_player_x))))
    f === :player_anim && return unsafe_load(Ptr{Float64}(x + offsetof(Platformer, Val(:player_anim))))
    f === :last_frame_time && return unsafe_load(Ptr{UInt64}(x + offsetof(Platformer, Val(:last_frame_time))))
    f === :actors && return unsafe_load(Ptr{Ptr{Actor}}(x + offsetof(Platformer, Val(:actors))))
    f === :sprites && return unsafe_load(Ptr{Ptr{SpriteBank}}(x + offsetof(Platformer, Val(:sprites))))
    f === :source_rect && return unsafe_load(Ptr{Ptr{SDL_Rect}}(x + offsetof(Platformer, Val(:source_rect))))
    f === :dest_rect && return unsafe_load(Ptr{Ptr{SDL_Rect}}(x + offsetof(Platformer, Val(:dest_rect))))
    f === :event && return unsafe_load(Ptr{Ptr{SDL_Event}}(x + offsetof(Platformer, Val(:event))))
    f === :jump_sound && return unsafe_load(Ptr{Ptr{Mix_Chunk}}(x + offsetof(Platformer, Val(:jump_sound))))
    f === :coin_sound && return unsafe_load(Ptr{Ptr{Mix_Chunk}}(x + offsetof(Platformer, Val(:coin_sound))))
    f === :music && return unsafe_load(Ptr{Ptr{Mix_Music}}(x + offsetof(Platformer, Val(:music))))
end

function Base.setproperty!(x::Ptr{Platformer}, f::Symbol, v::Any)
    f === :quit && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:quit))), v)
    f === :on_title && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:on_title))), v)
    f === :won && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:won))), v)
    f === :jump_held && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_held))), v)
    f === :jump_pressed && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_pressed))), v)
    f === :jump_released && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:jump_released))), v)
    f === :move_left && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:move_left))), v)
    f === :move_right && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:move_right))), v)
    f === :enter_pressed && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:enter_pressed))), v)
    f === :grounded && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:grounded))), v)
    f === :facing_right && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:facing_right))), v)
    f === :title_fading_out && return unsafe_store!(Ptr{Bool}(x + offsetof(Platformer, Val(:title_fading_out))), v)
    f === :level_index && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:level_index))), v)
    f === :coins_collected && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:coins_collected))), v)
    f === :coin_total && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:coin_total))), v)
    f === :star_count && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:star_count))), v)
    f === :deaths_this_level && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:deaths_this_level))), v)
    f === :title_alpha && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:title_alpha))), v)
    f === :clear_red && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_red))), v)
    f === :clear_green && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_green))), v)
    f === :clear_blue && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:clear_blue))), v)
    f === :actor_count && return unsafe_store!(Ptr{Int32}(x + offsetof(Platformer, Val(:actor_count))), v)
    f === :player_x && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:player_x))), v)
    f === :player_y && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:player_y))), v)
    f === :player_vx && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:player_vx))), v)
    f === :player_vy && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:player_vy))), v)
    f === :spawn_x && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:spawn_x))), v)
    f === :spawn_y && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:spawn_y))), v)
    f === :jump_velocity && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:jump_velocity))), v)
    f === :min_jump_velocity && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:min_jump_velocity))), v)
    f === :jump_dampening && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:jump_dampening))), v)
    f === :camera_x && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_x))), v)
    f === :camera_y && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_y))), v)
    f === :camera_target_x && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_target_x))), v)
    f === :camera_velocity && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:camera_velocity))), v)
    f === :last_player_x && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:last_player_x))), v)
    f === :player_anim && return unsafe_store!(Ptr{Float64}(x + offsetof(Platformer, Val(:player_anim))), v)
    f === :last_frame_time && return unsafe_store!(Ptr{UInt64}(x + offsetof(Platformer, Val(:last_frame_time))), v)
    f === :actors && return unsafe_store!(Ptr{Ptr{Actor}}(x + offsetof(Platformer, Val(:actors))), v)
    f === :sprites && return unsafe_store!(Ptr{Ptr{SpriteBank}}(x + offsetof(Platformer, Val(:sprites))), v)
    f === :source_rect && return unsafe_store!(Ptr{Ptr{SDL_Rect}}(x + offsetof(Platformer, Val(:source_rect))), v)
    f === :dest_rect && return unsafe_store!(Ptr{Ptr{SDL_Rect}}(x + offsetof(Platformer, Val(:dest_rect))), v)
    f === :event && return unsafe_store!(Ptr{Ptr{SDL_Event}}(x + offsetof(Platformer, Val(:event))), v)
    f === :jump_sound && return unsafe_store!(Ptr{Ptr{Mix_Chunk}}(x + offsetof(Platformer, Val(:jump_sound))), v)
    f === :coin_sound && return unsafe_store!(Ptr{Ptr{Mix_Chunk}}(x + offsetof(Platformer, Val(:coin_sound))), v)
    f === :music && return unsafe_store!(Ptr{Ptr{Mix_Music}}(x + offsetof(Platformer, Val(:music))), v)
end
