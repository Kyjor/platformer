#include <stdio.h>
#include <stdlib.h>
#ifdef __APPLE__
#include <libgen.h>
#include <mach-o/dyld.h>
#include <unistd.h>
#endif

// External declaration of the Julia pc_main function
extern int pc_main(void);

#ifdef __APPLE__
static void chdir_to_executable(void) {
    char path[4096];
    uint32_t size = sizeof(path);
    if (_NSGetExecutablePath(path, &size) != 0) {
        return;
    }
    char resolved[4096];
    if (realpath(path, resolved) == NULL) {
        return;
    }
    char *dir = dirname(resolved);
    if (dir == NULL) {
        return;
    }
    chdir(dir);
    if (access("assets", F_OK) != 0 && access("../Resources/assets", F_OK) == 0) {
        chdir("../Resources");
    }
}
#endif

int main(int argc, char* argv[]) {
#ifdef __APPLE__
    chdir_to_executable();
#endif
    printf("🚀 Starting Julia + SDL2 Game...\n");
    
    // Call the Julia main function
    int result = pc_main();
    
    if (result == 0) {
        printf("✅ Game exited successfully\n");
    } else {
        printf("❌ Game exited with error code: %d\n", result);
    }
    
    return result;
} 