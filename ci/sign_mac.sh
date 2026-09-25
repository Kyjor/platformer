#!/usr/bin/env bash
# Sign (and optionally notarize) the packaged Platformer.app with team AKG5NATH99.
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
app="${1:-$root/dist/platformer/Platformer.app}"
identity="${CODESIGN_IDENTITY:-Developer ID Application: Kyle Conel (AKG5NATH99)}"
entitlements="$root/ci/macos/entitlements.plist"
zip_path="$root/dist/platformer-macos-arm64.zip"

if [[ "$(uname)" != Darwin ]]; then
  echo "macOS signing only"
  exit 1
fi
if [[ ! -d "$app" ]]; then
  echo "missing app bundle: $app"
  exit 1
fi
if [[ ! -f "$entitlements" ]]; then
  echo "missing entitlements: $entitlements"
  exit 1
fi

# codesign can fail to read plists under ~/Documents due to TCC.
ent_copy="$(mktemp -t platformer-entitlements)"
cp "$entitlements" "$ent_copy"
trap 'rm -f "$ent_copy"' EXIT

echo "Signing with $identity"
find "$app" -type f \( -name "*.dylib" -o -name "*.so" \) -print0 |
  while IFS= read -r -d '' lib; do
    codesign --force --options runtime --timestamp --sign "$identity" "$lib"
  done
if [[ -d "$app/Contents/Frameworks" ]]; then
  find "$app/Contents/Frameworks" -name "*.framework" -prune -print0 |
    while IFS= read -r -d '' fw; do
      codesign --force --options runtime --timestamp --sign "$identity" "$fw"
    done
fi

codesign --force --options runtime --timestamp --entitlements "$ent_copy" \
  --sign "$identity" "$app/Contents/MacOS/game"
codesign --force --options runtime --timestamp --entitlements "$ent_copy" \
  --sign "$identity" "$app"
codesign --verify --deep --strict --verbose=2 "$app"

rm -f "$zip_path"
/usr/bin/ditto -c -k --keepParent "$app" "$zip_path"

notarize=0
if [[ -n "${APP_STORE_CONNECT_API_KEY_PATH:-}" && -n "${APP_STORE_CONNECT_API_KEY_ID:-}" && -n "${APP_STORE_CONNECT_ISSUER_ID:-}" ]]; then
  notarize=1
  xcrun notarytool submit "$zip_path" --wait \
    --key "$APP_STORE_CONNECT_API_KEY_PATH" \
    --key-id "$APP_STORE_CONNECT_API_KEY_ID" \
    --issuer "$APP_STORE_CONNECT_ISSUER_ID"
elif [[ -n "${APPLE_ID:-}" && -n "${APPLE_TEAM_ID:-}" && -n "${NOTARY_APP_PASSWORD:-}" ]]; then
  notarize=1
  xcrun notarytool store-credentials platformer-notary \
    --apple-id "$APPLE_ID" \
    --team-id "$APPLE_TEAM_ID" \
    --password "$NOTARY_APP_PASSWORD"
  xcrun notarytool submit "$zip_path" --keychain-profile platformer-notary --wait
elif [[ -n "${GITHUB_ACTIONS:-}" ]]; then
  echo "Missing notarization credentials on CI"
  exit 1
else
  echo "Signed $app (skip notarization — no credentials)"
fi

if [[ "$notarize" -eq 1 ]]; then
  xcrun stapler staple "$app"
  rm -f "$zip_path"
  /usr/bin/ditto -c -k --keepParent "$app" "$zip_path"
  echo "Notarized and stapled $app"
fi

echo "$zip_path"
