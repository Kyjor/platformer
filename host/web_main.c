#ifdef __EMSCRIPTEN__
#include <SDL.h>
#include <emscripten.h>
#include <stdint.h>
#include <stdio.h>

uint64_t j_init_game_state(uint64_t renderer, uint64_t window);
uint64_t game_loop(uint64_t state, uint64_t renderer, uint64_t window);

static SDL_Window *g_window;
static SDL_Renderer *g_renderer;
static uint64_t g_state;

static void frame(void) {
    if (g_state == 0) {
        return;
    }
    g_state = game_loop(g_state, (uint64_t)(uintptr_t)g_renderer, (uint64_t)(uintptr_t)g_window);
}

int main(void) {
    SDL_SetHint(SDL_HINT_EMSCRIPTEN_CANVAS_SELECTOR, "#canvas");
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO) != 0) {
        printf("SDL_Init failed: %s\n", SDL_GetError());
        return 1;
    }
    g_window = SDL_CreateWindow("Platformer", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, 1280, 720, SDL_WINDOW_SHOWN);
    if (g_window == NULL) {
        printf("SDL_CreateWindow failed: %s\n", SDL_GetError());
        return 1;
    }
    g_renderer = SDL_CreateRenderer(g_window, -1, SDL_RENDERER_ACCELERATED);
    if (g_renderer == NULL) {
        printf("accelerated renderer failed (%s); trying software\n", SDL_GetError());
        g_renderer = SDL_CreateRenderer(g_window, -1, SDL_RENDERER_SOFTWARE);
    }
    if (g_renderer == NULL) {
        printf("SDL_CreateRenderer failed: %s\n", SDL_GetError());
        return 1;
    }
    SDL_RenderSetScale(g_renderer, 4.0f, 4.0f);
    g_state = j_init_game_state((uint64_t)(uintptr_t)g_renderer, (uint64_t)(uintptr_t)g_window);
    if (g_state == 0) {
        printf("j_init_game_state failed\n");
        return 1;
    }
    emscripten_set_main_loop(frame, 0, 1);
    return 0;
}
#endif
