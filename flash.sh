#!/usr/bin/env bash
# Flash with the keyboard's script from qmk-armed. Usage: ./flash.sh [firmware.bin]
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
exec "$HERE/qmk-armed/keyboards/io/type84_pro/flash.sh" "${1:-$HERE/qmk-armed/io_type84_pro_default.bin}"
