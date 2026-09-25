function load_texture(renderer::Ptr{SDL_Renderer}, path::Ptr{UInt8})::Ptr{SDL_Texture}
    surface::Ptr{SDL_Surface} = llvm_IMG_Load(path)
    if surface == Ptr{SDL_Surface}(C_NULL)
        printf(c"missing sprite %s\n", path)
        return Ptr{SDL_Texture}(C_NULL)
    end
    texture::Ptr{SDL_Texture} = llvm_SDL_CreateTextureFromSurface(renderer, surface)
    llvm_SDL_FreeSurface(surface)
    if texture == Ptr{SDL_Texture}(C_NULL)
        printf(c"texture failed %s\n", path)
        return texture
    end
    llvm_SDL_SetTextureBlendMode(texture, UInt32(1))
    return texture
end

function bank_texture(bank::Ptr{SpriteBank}, texture_id::Int32)::Ptr{SDL_Texture}
    if texture_id == TEX_PLAYER
        return bank.player
    elseif texture_id == TEX_SPIDER_FOREST
        return bank.spider_forest
    elseif texture_id == TEX_SPIDER_CASTLE
        return bank.spider_castle
    elseif texture_id == TEX_FISH
        return bank.fish
    elseif texture_id == TEX_FLAME_CASTLE
        return bank.flame_castle
    elseif texture_id == TEX_FLAME_SKY
        return bank.flame_sky
    elseif texture_id == TEX_COIN
        return bank.coin
    elseif texture_id == TEX_STAR
        return bank.star
    elseif texture_id == TEX_SAW
        return bank.saw
    elseif texture_id == TEX_WATER
        return bank.water
    elseif texture_id == TEX_LAVA
        return bank.lava
    elseif texture_id == TEX_CLOUDS
        return bank.clouds
    elseif texture_id == TEX_FOREST_BACKGROUND
        return bank.forest_background
    elseif texture_id == TEX_CASTLE_BACKGROUND
        return bank.castle_background
    elseif texture_id == TEX_SKY_FAR
        return bank.sky_far
    elseif texture_id == TEX_SKY_MID
        return bank.sky_mid
    elseif texture_id == TEX_SKY_NEAR
        return bank.sky_near
    elseif texture_id == TEX_GRASS_ONEWAY
        return bank.grass_oneway
    elseif texture_id == TEX_GRASS_TILESET
        return bank.grass_tileset
    elseif texture_id == TEX_BRICK_ONEWAY
        return bank.brick_oneway
    elseif texture_id == TEX_BRICK_TILESET
        return bank.brick_tileset
    elseif texture_id == TEX_ROCK_ONEWAY
        return bank.rock_oneway
    elseif texture_id == TEX_ROCK_TILESET
        return bank.rock_tileset
    elseif texture_id == TEX_BRIDGE
        return bank.bridge
    elseif texture_id == TEX_STARS_ICON
        return bank.stars_icon
    elseif texture_id == TEX_COINS_ICON
        return bank.coins_icon
    elseif texture_id == TEX_LOGO
        return bank.logo
    elseif texture_id == TEX_KEY_SPACE
        return bank.key_space
    elseif texture_id == TEX_KEY_UP
        return bank.key_up
    elseif texture_id == TEX_KEY_DOWN
        return bank.key_down
    elseif texture_id == TEX_KEY_LEFT
        return bank.key_left
    elseif texture_id == TEX_KEY_RIGHT
        return bank.key_right
    end
    return Ptr{SDL_Texture}(C_NULL)
end

function destroy_one_texture(texture::Ptr{SDL_Texture})::Cvoid
    if texture != Ptr{SDL_Texture}(C_NULL)
        llvm_SDL_DestroyTexture(texture)
    end
    return nothing
end

function destroy_sprite_bank(bank::Ptr{SpriteBank})::Cvoid
    destroy_one_texture(bank.player)
    destroy_one_texture(bank.spider_forest)
    destroy_one_texture(bank.spider_castle)
    destroy_one_texture(bank.fish)
    destroy_one_texture(bank.flame_castle)
    destroy_one_texture(bank.flame_sky)
    destroy_one_texture(bank.coin)
    destroy_one_texture(bank.star)
    destroy_one_texture(bank.saw)
    destroy_one_texture(bank.water)
    destroy_one_texture(bank.lava)
    destroy_one_texture(bank.clouds)
    destroy_one_texture(bank.forest_background)
    destroy_one_texture(bank.castle_background)
    destroy_one_texture(bank.sky_far)
    destroy_one_texture(bank.sky_mid)
    destroy_one_texture(bank.sky_near)
    destroy_one_texture(bank.grass_oneway)
    destroy_one_texture(bank.grass_tileset)
    destroy_one_texture(bank.brick_oneway)
    destroy_one_texture(bank.brick_tileset)
    destroy_one_texture(bank.rock_oneway)
    destroy_one_texture(bank.rock_tileset)
    destroy_one_texture(bank.bridge)
    destroy_one_texture(bank.stars_icon)
    destroy_one_texture(bank.coins_icon)
    destroy_one_texture(bank.logo)
    destroy_one_texture(bank.key_space)
    destroy_one_texture(bank.key_up)
    destroy_one_texture(bank.key_down)
    destroy_one_texture(bank.key_left)
    destroy_one_texture(bank.key_right)
    return nothing
end

function load_sprite_bank(renderer::Ptr{SDL_Renderer}, bank::Ptr{SpriteBank})::Int32
    path = c"assets/images/Player.png"
    player::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Spider_1.png"
    spider_forest::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Spider_2.png"
    spider_castle::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Fish_1.png"
    fish::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Flame_1.png"
    flame_castle::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Flame_2.png"
    flame_sky::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Coin.png"
    coin::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Star_Red.png"
    star::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Circular_Saw.png"
    saw::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Water.png"
    water::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Lava.png"
    lava::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Clouds.png"
    clouds::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Forest_Background_0.png"
    forest_background::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Castle_Background_0.png"
    castle_background::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Sky_Background_0.png"
    sky_far::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Sky_Background_1.png"
    sky_mid::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Sky_Background_2.png"
    sky_near::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Grass_Oneway.png"
    grass_oneway::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Grass_Tileset.png"
    grass_tileset::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Brick_Oneway.png"
    brick_oneway::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Brick_Tileset.png"
    brick_tileset::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Grass_Rock_Oneway.png"
    rock_oneway::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Grass_Rock_Tileset.png"
    rock_tileset::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Bridge.png"
    bridge::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Stars_Ui.png"
    stars_icon::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Coins_Ui.png"
    coins_icon::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Logo.png"
    logo::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Space_Key_Dark.png"
    key_space::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Arrow_Up_Key_Dark.png"
    key_up::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Arrow_Down_Key_Dark.png"
    key_down::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Arrow_Left_Key_Dark.png"
    key_left::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    path = c"assets/images/Arrow_Right_Key_Dark.png"
    key_right::Ptr{SDL_Texture} = GC.@preserve path load_texture(renderer, pointer(path))
    if player == Ptr{SDL_Texture}(C_NULL) || grass_oneway == Ptr{SDL_Texture}(C_NULL) || forest_background == Ptr{SDL_Texture}(C_NULL)
        return Int32(1)
    end
    unsafe_store!(bank, SpriteBank(player, spider_forest, spider_castle, fish, flame_castle, flame_sky, coin, star, saw, water, lava, clouds, forest_background, castle_background, sky_far, sky_mid, sky_near, grass_oneway, grass_tileset, brick_oneway, brick_tileset, rock_oneway, rock_tileset, bridge, stars_icon, coins_icon, logo, key_space, key_up, key_down, key_left, key_right))
    return Int32(0)
end
