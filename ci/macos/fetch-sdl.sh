#!/usr/bin/env bash
# Official SDL2 frameworks — not Homebrew sdl2-compat, which is an SDL3 shim.
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
dest="${SDL_FRAMEWORK_PATH:-$root/.sdl-frameworks}"
mkdir -p "$dest"

fetch() {
  local url="$1" name="$2"
  if [[ -d "$dest/$name" ]]; then
    return
  fi
  local dmg mp
  dmg="$(mktemp -t sdl2).dmg"
  mp="$(mktemp -d)"
  curl -fsSL -o "$dmg" "$url"
  hdiutil attach "$dmg" -nobrowse -readonly -mountpoint "$mp" >/dev/null
  local found
  found="$(find "$mp" -name "$name" -type d | head -1)"
  if [[ -z "$found" ]]; then
    echo "missing $name in $url"
    hdiutil detach "$mp" >/dev/null || true
    exit 1
  fi
  rm -rf "$dest/$name"
  cp -R "$found" "$dest/$name"
  hdiutil detach "$mp" >/dev/null
  rm -f "$dmg"
  rmdir "$mp"
}

fetch "https://github.com/libsdl-org/SDL/releases/download/release-2.32.10/SDL2-2.32.10.dmg" SDL2.framework
fetch "https://github.com/libsdl-org/SDL_image/releases/download/release-2.8.8/SDL2_image-2.8.8.dmg" SDL2_image.framework
fetch "https://github.com/libsdl-org/SDL_mixer/releases/download/release-2.8.1/SDL2_mixer-2.8.1.dmg" SDL2_mixer.framework

export SDL_FRAMEWORK_PATH="$dest"
if [[ -n "${GITHUB_ENV:-}" ]]; then
  echo "SDL_FRAMEWORK_PATH=$dest" >> "$GITHUB_ENV"
fi
echo "SDL_FRAMEWORK_PATH=$dest"
