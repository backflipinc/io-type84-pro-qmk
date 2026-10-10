#!/usr/bin/env bash
# Fetch qmk-armed (the QMK fork with this keyboard) at the pinned commit, plus the QMK libraries it needs.
#
# Usage: ./setup.sh
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
say() { printf '\033[1;33m==>\033[0m %s\n' "$*"; }

say "Fetching qmk-armed"
git -C "$HERE" submodule update --init --depth 1 qmk-armed

# not recursive: ChibiOS-Contrib's own submodules are for other MCUs
say "Fetching QMK libraries (ChibiOS, ChibiOS-Contrib, LUFA, ...)"
git -C "$HERE/qmk-armed" submodule update --init --depth 1

cat <<MSG

Done. Build with:

  make -C qmk-armed io/type84_pro:default     # with Vial; io/type84_pro:novial without

(needs make, python3 with the 'qmk' package, and arm-none-eabi-gcc in PATH)
MSG
