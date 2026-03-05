#!/bin/bash

set -e

REPO_ROOT="$HOME/.config/dotfiles"
CONFIG_ROOT="$HOME/.config"

FILES=(fish flameshot foot hypr mako nvim rofi starship.toml waybar)

cd "$REPO_ROOT"

for f in "${FILES[@]}"; do
    src="$CONFIG_ROOT/$f"
    dest="$REPO_ROOT/$f"

    rm -rf "$dest"

    if [ -d "$src" ]; then
        mkdir -p "$dest"
        cp -r "$src/." "$dest"
    elif [ -f "$src" ]; then
        cp "$src" "$dest"
    fi
done

git add .
git commit -m "Updated dotfiles"
git push origin main
