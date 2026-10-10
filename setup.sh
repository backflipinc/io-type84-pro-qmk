#!/usr/bin/env bash
# Prepare a SonixQMK tree for building the IO Type 84 Pro firmware:
#   1. clone SonixQMK (sn32_develop) at the tested commit (if not there yet),
#   2. apply our core patches (USB HID battery report, Vial from vial-qmk),
#   3. link this repo's keyboard folder into keyboards/io/type84_pro.
#
# Usage: ./setup.sh [path-to-qmk_firmware]     (default: ./qmk_firmware)
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
QMK_DIR="${1:-$HERE/qmk_firmware}"
QMK_REPO="https://github.com/SonixQMK/qmk_firmware.git"
QMK_BRANCH="sn32_develop"
QMK_REF="b7b245d014721f727f0f8f701026939468f4c916" # tested with this commit

say() { printf '\033[1;33m==>\033[0m %s\n' "$*"; }

if [ ! -d "$QMK_DIR/.git" ]; then
    say "Cloning SonixQMK ($QMK_BRANCH) into $QMK_DIR"
    git clone --filter=blob:none --branch "$QMK_BRANCH" "$QMK_REPO" "$QMK_DIR"
fi

if [ "$(git -C "$QMK_DIR" rev-parse HEAD)" != "$QMK_REF" ]; then
    say "Checking out tested commit ${QMK_REF:0:10}"
    git -C "$QMK_DIR" fetch --quiet origin "$QMK_REF" || true
    git -C "$QMK_DIR" checkout --quiet "$QMK_REF"
fi

say "Updating submodules (ChibiOS, ChibiOS-Contrib, ...)"
git -C "$QMK_DIR" submodule update --init --recursive --depth 1

for PATCH in "$HERE/patches/hid-battery.patch" "$HERE/patches/vial.patch"; do
    if git -C "$QMK_DIR" apply --reverse --check "$PATCH" 2>/dev/null; then
        say "Core patch already applied: $(basename "$PATCH")"
    else
        say "Applying core patch: $(basename "$PATCH")"
        git -C "$QMK_DIR" apply "$PATCH"
    fi
done

mkdir -p "$QMK_DIR/keyboards/io"
LINK="$QMK_DIR/keyboards/io/type84_pro"
if [ -L "$LINK" ] || [ ! -e "$LINK" ]; then
    ln -sfn "$HERE/keyboards/io/type84_pro" "$LINK"
    say "Linked keyboards/io/type84_pro -> $HERE/keyboards/io/type84_pro"
else
    echo "warning: $LINK exists and is not a symlink, leaving it alone" >&2
fi

cat <<EOF

Done. Build with:

  cd "$QMK_DIR"
  make io/type84_pro:default     # with Vial; io/type84_pro:novial without

(needs make, python3 with the 'qmk' package, and arm-none-eabi-gcc in PATH)
EOF
