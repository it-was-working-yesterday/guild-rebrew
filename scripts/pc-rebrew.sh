#!/usr/bin/env bash
# Runs inside the PC's WSL Debian (user rebrew) as a worker task: worker run rebrew -- <rebrew args>
# $1 = Windows path of the synced source tree ({src}), $2 = Windows artifacts dir, rest = rebrew args.
# rsyncs the synced tree to a WSL-local lane dir (ext4), runs rebrew there, copies managed metadata back to artifacts.
set -u
SRC=$(wslpath "$1"); ART=$(wslpath "$2"); shift 2
LANE=${LANE_ROOT:-/var/tmp/lanes}/$(basename "$(dirname "$SRC")")
export PATH=$HOME/.local/bin:$PATH
mkdir -p "$LANE" "$ART"
rsync -a --delete \
  --exclude=/original --exclude=/.venv --exclude=/cmake/toolchain-overlays --exclude=/.rebrew --exclude=/.toml-hash --exclude=/rebrew-metadata.sqlite3* \
  "$SRC"/ "$LANE"/
cd "$LANE" || exit 126
# the synced TOML stores are the truth. The lane sqlite replica makes metadata reads ~10x faster, so keep it
# while the synced TOMLs are exactly what the last run left behind; otherwise drop it (rebuilt from TOML).
cur=$(cat rebrew-functions.toml rebrew-data.toml rebrew-types.toml | sha256sum | cut -d' ' -f1)
[ "$cur" = "$(cat .toml-hash 2>/dev/null)" ] || rm -f rebrew-metadata.sqlite3*
touch "$ART/.mark"
find src stubs -type f 2>/dev/null | sort > "$ART/files.before"
[ -e original ] || cp -a /srv/guild-rebrew/original original
[ -d cmake/toolchain-overlays ] || cp -a /srv/guild-rebrew/cmake/toolchain-overlays cmake/
export REBREW_TOOLCHAIN_OVERLAY_DIR=$LANE/cmake/toolchain-overlays
[ -d .venv/bin ] || uv sync --frozen >&2 || exit 126
if [ "${1:-}" = "--sh" ]; then shift; bash -c "$@"; rc=$?; else uv run rebrew "$@"; rc=$?; fi
find src stubs -type f 2>/dev/null | sort > "$ART/files.after"
(find src stubs -type f -newer "$ART/.mark" -print0 2>/dev/null | xargs -0 -r tar -cf "$ART/changed-src.tar") 2>/dev/null
[ -e rebrew-metadata.sqlite3 ] && cat rebrew-functions.toml rebrew-data.toml rebrew-types.toml | sha256sum | cut -d" " -f1 > .toml-hash || rm -f .toml-hash
for f in rebrew-functions.toml rebrew-data.toml rebrew-types.toml; do
  [ -e "$f" ] && [ "$f" -nt "$ART/.mark" ] && cp -p "$f" "$ART"/ 2>/dev/null
done
exit $rc
