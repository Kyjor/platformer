function play_level_music(state::Ptr{Platformer})::Cvoid
    if state.music != Ptr{Mix_Music}(C_NULL)
        llvm_Mix_HaltMusic()
        llvm_Mix_FreeMusic(state.music)
        state.music = Ptr{Mix_Music}(C_NULL)
    end
    loaded::Ptr{Mix_Music} = Ptr{Mix_Music}(C_NULL)
    if state.level_index == Int32(1)
        water_path = c"assets/sounds/water-ambience.mp3"
        loaded = GC.@preserve water_path llvm_Mix_LoadMUS(pointer(water_path))
    elseif state.level_index == Int32(2)
        lava_path = c"assets/sounds/lava.wav"
        loaded = GC.@preserve lava_path llvm_Mix_LoadMUS(pointer(lava_path))
    else
        wind_path = c"assets/sounds/strong-wind.wav"
        loaded = GC.@preserve wind_path llvm_Mix_LoadMUS(pointer(wind_path))
    end
    state.music = loaded
    if loaded != Ptr{Mix_Music}(C_NULL)
        llvm_Mix_VolumeMusic(Int32(25))
        llvm_Mix_PlayMusic(loaded, Int32(-1))
    end
    return nothing
end

function prepare_level_presentation(state::Ptr{Platformer})::Cvoid
    state.clear_red = Int32(30)
    state.clear_green = Int32(111)
    state.clear_blue = Int32(80)
    return nothing
end

function complete_level(state::Ptr{Platformer})::Cvoid
    if state.deaths_this_level == Int32(0)
        state.star_count += Int32(1)
    end
    if state.level_index < Int32(3)
        load_level(state, state.level_index + Int32(1))
    else
        state.won = true
        printf(c"You win\n")
    end
    return nothing
end
