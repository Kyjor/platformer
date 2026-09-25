#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v emcc >/dev/null 2>&1; then
  echo "emcc not in PATH"
  exit 1
fi

# emcc lives in $EMSDK/upstream/emscripten; llvm-link is in $EMSDK/upstream/bin.
if [[ -n "${EMSDK:-}" && -d "$EMSDK/upstream/bin" ]]; then
  export PATH="$EMSDK/upstream/bin:$PATH"
fi
emcc_dir="$(dirname "$(command -v emcc)")"
if [[ -d "$emcc_dir/../bin" ]]; then
  export PATH="$(cd "$emcc_dir/../bin" && pwd):$PATH"
fi

if ! command -v llvm-link >/dev/null 2>&1; then
  echo "llvm-link not in PATH; installing llvm"
  sudo apt-get update
  sudo apt-get install -y llvm
fi

if ! command -v llvm-link >/dev/null 2>&1; then
  echo "llvm-link still not in PATH"
  exit 1
fi

echo "emcc: $(command -v emcc)"
echo "llvm-link: $(command -v llvm-link)"

julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. compile.jl web
python3 ci/package.py web
