#!/usr/bin/env bash
# Runs inside the PC's WSL Debian (user rebrew) as a worker task: worker run rebrew -- <rebrew args>
# $1 = Windows path of the synced source tree ({src}), $2 = Windows artifacts dir, rest = rebrew args.
# Copies the synced tree to a WSL-local lane dir (ext4), runs rebrew there, copies managed metadata back to artifacts.
set -u
SRC=$(wslpath "$1"); ART=$(wslpath "$2"); shift 2
LANE=${LANE_ROOT:-/var/tmp/lanes}/$(basename "$(dirname "$SRC")")
export PATH=$HOME/.local/bin:$PATH
mkdir -p "$LANE" "$ART"
tar -C "$SRC" -cf - . | tar -C "$LANE" -xf -
cd "$LANE" || exit 126
[ -e original ] || cp -a /srv/guild-rebrew/original original
[ -d cmake/toolchain-overlays ] || cp -a /srv/guild-rebrew/cmake/toolchain-overlays cmake/
export REBREW_TOOLCHAIN_OVERLAY_DIR=$LANE/cmake/toolchain-overlays
[ -d .venv/bin ] || uv sync --frozen >&2 || exit 126
if [ "${1:-}" = "--sh" ]; then shift; bash -c "$@"; rc=$?; else uv run rebrew "$@"; rc=$?; fi
cp -p rebrew-functions.toml rebrew-data.toml rebrew-types.toml "$ART"/ 2>/dev/null
exit $rc
