#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
if [[ "$(uname)" == Darwin ]]; then
  # shellcheck source=macos/fetch-sdl.sh
  source ci/macos/fetch-sdl.sh
fi
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. compile.jl
if command -v python3 >/dev/null 2>&1; then
    python3 ci/package.py
else
    python ci/package.py
fi
