#!/usr/bin/env python3
import os
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


def bundle_mac(binary: Path):
    fw_src = Path(os.environ.get("SDL_FRAMEWORK_PATH", ""))
    if not fw_src.is_dir():
        sys.exit("SDL_FRAMEWORK_PATH is unset; run ci/macos/fetch-sdl.sh")
    dest = binary.parent / "Frameworks"
    dest.mkdir()
    for name in ("SDL2.framework", "SDL2_image.framework", "SDL2_mixer.framework"):
        src = fw_src / name
        if not src.is_dir():
            sys.exit(f"missing {src}")
        shutil.copytree(src, dest / name, symlinks=True)


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
        if item.name == "assets":
            dest = resources / item.name
        elif item.name == "Frameworks":
            dest = app / "Contents" / "Frameworks"
        else:
            dest = macos / item.name
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


def package_web():
    js = build / "game.js"
    wasm = build / "game.wasm"
    data = build / "game.data"
    for path in (js, wasm, data):
        if not path.is_file():
            sys.exit(f"missing {path}")
    stage = root / "dist" / "platformer-web"
    if stage.exists():
        shutil.rmtree(stage)
    stage.mkdir(parents=True)
    shutil.copy2(root / "web" / "index.html", stage / "index.html")
    shutil.copy2(root / "web" / "index.js", stage / "index.js")
    shutil.copy2(js, stage / "game.js")
    shutil.copy2(wasm, stage / "game.wasm")
    shutil.copy2(data, stage / "game.data")
    zip_path = root / "dist" / "platformer-web"
    shutil.make_archive(str(zip_path), "zip", root / "dist", "platformer-web")
    print(zip_path.with_suffix(".zip"))


def main():
    if len(sys.argv) > 1 and sys.argv[1] == "web":
        package_web()
        return

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
