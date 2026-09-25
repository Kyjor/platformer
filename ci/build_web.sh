#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v emcc >/dev/null 2>&1; then
  echo "emcc not in PATH"
  exit 1
fi

emcc_bin="$(command -v emcc)"
emsdk_llvm="$(cd "$(dirname "$emcc_bin")/../bin" && pwd)"
if [[ -x "$emsdk_llvm/llvm-link" ]]; then
  export PATH="$emsdk_llvm:$PATH"
fi

if ! command -v llvm-link >/dev/null 2>&1; then
  echo "llvm-link not in PATH"
  exit 1
fi

julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. compile.jl web
python3 ci/package.py web
