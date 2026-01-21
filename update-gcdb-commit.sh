#!/bin/sh -eu

PKGS="$@"
GCDB_COMMIT="$(curl -s https://api.github.com/repos/mdqinc/SDL_GameControllerDB/commits/master 2>/dev/null | jq -r .sha)"

if [ -z "$GCDB_COMMIT" ]; then
    echo "Error: Cannot fetch SDL_GameControllerDB commit id"
    exit 1
fi

echo "$GCDB_COMMIT"
for pkg in "${PKGS[@]}"; do
    sed -E -i "/_sdl_gcdb_commit=/s/[0-9a-fA-F]{40}/$GCDB_COMMIT/" "$pkg/PKGBUILD"
done
