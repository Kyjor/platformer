#!/usr/bin/env python3
import platform
import shutil
import subprocess
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
build = root / "build"
stage_root = root / "dist" / "platformer"

SKIP_LINUX = {
    "libc.so.6",
    "libm.so.6",
    "libdl.so.2",
    "libpthread.so.0",
    "librt.so.1",
    "libresolv.so.2",
    "libgcc_s.so.1",
    "libstdc++.so.6",
}


def skip_linux(path: Path) -> bool:
    name = path.name
    if name.startswith("ld-linux"):
        return True
    if name in SKIP_LINUX:
        return True
    return name.startswith((
        "libGL",
        "libGLdispatch",
        "libX",
        "libxcb",
        "libwayland",
        "libdrm",
        "libgbm",
    ))


def ldd(path: Path):
    output = subprocess.check_output(["ldd", str(path)], text=True, errors="replace")
    libs = []
    for line in output.splitlines():
        if "=>" not in line:
            continue
        parts = line.strip().split()
        if len(parts) >= 3 and parts[2].startswith("/"):
            libs.append(Path(parts[2]))
    return libs


def force_origin_rpath(path: Path):
    subprocess.check_call(["patchelf", "--force-rpath", "--set-rpath", "$ORIGIN", str(path)])


def bundle_linux(binary: Path):
    seen = set()
    queue = [binary]
    while queue:
        current = queue.pop()
        for lib in ldd(current):
            if lib in seen or skip_linux(lib):
                continue
            seen.add(lib)
            dest = stage_root / lib.name
            shutil.copy2(lib, dest)
            queue.append(dest)
    force_origin_rpath(binary)
    for lib in stage_root.glob("*.so*"):
        force_origin_rpath(lib)


def find_sdl3() -> Path | None:
    for cmd in (
        ["pkg-config", "--variable=libdir", "sdl3"],
        ["brew", "--prefix", "sdl3"],
    ):
        try:
            out = subprocess.check_output(cmd, text=True, stderr=subprocess.DEVNULL).strip()
        except (subprocess.CalledProcessError, FileNotFoundError):
            continue
        libdir = Path(out) if Path(out).name == "lib" else Path(out) / "lib"
        for name in ("libSDL3.dylib", "libSDL3.0.dylib"):
            cand = libdir / name
            if cand.exists():
                return cand.resolve()
    return None


def sdl2_needs_sdl3(lib: Path) -> bool:
    for path in lib.glob("libSDL2*.dylib"):
        data = path.read_bytes()
        if b"sdl2-compat" in data or b"Failed loading SDL3" in data:
            return True
    return False


def bundle_mac(binary: Path):
    lib = binary.parent / "lib"
    lib.mkdir()
    subprocess.check_call([
        "dylibbundler",
        "-od",
        "-b",
        "-x",
        str(binary),
        "-d",
        str(lib),
        "-p",
        "@executable_path/lib",
    ])
    # Homebrew SDL2 is sdl2-compat and dlopens SDL3, which dylibbundler cannot see.
    sdl3 = find_sdl3()
    if sdl3 is None:
        if sdl2_needs_sdl3(lib):
            sys.exit("SDL3 not found; Homebrew sdl2-compat loads it at runtime")
        return
    dest = lib / "libSDL3.dylib"
    shutil.copy2(sdl3, dest)
    shutil.copy2(sdl3, binary.parent / "libSDL3.dylib")
    subprocess.check_call([
        "dylibbundler",
        "-od",
        "-b",
        "-x",
        str(dest),
        "-d",
        str(lib),
        "-p",
        "@executable_path/lib",
    ])


def wrap_mac_app(stage: Path) -> Path:
    app = stage / "Platformer.app"
    macos = app / "Contents" / "MacOS"
    resources = app / "Contents" / "Resources"
    if app.exists():
        shutil.rmtree(app)
    macos.mkdir(parents=True)
    resources.mkdir(parents=True)
    shutil.copy2(root / "ci" / "macos" / "Info.plist", app / "Contents" / "Info.plist")
    for item in list(stage.iterdir()):
        if item.name == "Platformer.app":
            continue
        dest = resources / item.name if item.name == "assets" else macos / item.name
        shutil.move(str(item), str(dest))
    return app


def bundle_windows(binary: Path):
    output = subprocess.check_output(["ntldd", "-R", str(binary)], text=True, errors="replace")
    for line in output.splitlines():
        if "=>" not in line:
            continue
        path = line.split("=>", 1)[1].strip().split()[0]
        if path.lower() in {"", "not"}:
            continue
        source = Path(path)
        if not source.is_file():
            continue
        lowered = str(source).lower().replace("\\", "/")
        if "/windows/" in lowered:
            continue
        shutil.copy2(source, stage_root / source.name)


def main():
    if (build / "game.exe").exists():
        kind = "windows"
        binary_name = "game.exe"
        archive = "platformer-windows-x64"
    elif platform.system() == "Darwin":
        kind = "mac"
        binary_name = "game"
        archive = "platformer-macos-arm64"
    else:
        kind = "linux"
        binary_name = "game"
        archive = "platformer-linux-x64"

    binary = build / binary_name
    if not binary.is_file():
        sys.exit(f"missing {binary}")

    if stage_root.exists():
        shutil.rmtree(stage_root)
    stage_root.mkdir(parents=True)
    shutil.copy2(binary, stage_root / binary_name)
    shutil.copytree(root / "assets", stage_root / "assets")

    staged = stage_root / binary_name
    if kind == "linux":
        bundle_linux(staged)
    elif kind == "mac":
        bundle_mac(staged)
        wrap_mac_app(stage_root)
    else:
        bundle_windows(staged)

    zip_path = root / "dist" / archive
    archive_item = "Platformer.app" if kind == "mac" else "platformer"
    archive_root = stage_root if kind == "mac" else root / "dist"
    shutil.make_archive(str(zip_path), "zip", archive_root, archive_item)
    print(zip_path.with_suffix(".zip"))


if __name__ == "__main__":
    main()
