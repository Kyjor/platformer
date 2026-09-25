#ifdef __EMSCRIPTEN__
#include <SDL.h>
#include <emscripten.h>
#define KEEP EMSCRIPTEN_KEEPALIVE
#else
#include <SDL2/SDL.h>
#define KEEP
#endif
#include <stdint.h>
#include <stdio.h>
#include <string.h>

KEEP
int print_string(const char *str) {
    if (str && str[0] != '\0' && str[0] != '\n' && str[0] != '\r' &&
        str[0] != '\t' && str[0] != ' ' && str[0] != '\v' && str[0] != '\f' &&
        str[0] != '\b') {
        printf("%s\n", str);
    }
    return 1;
}

int sc_is_web(void) {
#ifdef __EMSCRIPTEN__
    return 1;
#else
    return 0;
#endif
}

static int32_t g_hi = 1;

KEEP
int32_t get_hi(void) {
    return g_hi;
}

KEEP
void set_hi(int32_t value) {
    g_hi = value;
}
