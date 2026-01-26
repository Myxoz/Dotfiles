#!/bin/bash
REPO_ROOT="$HOME/.config/dotfiles"
CONFIG_ROOT="$HOME/.config"

FILES=(fish flameshot foot hypr mako nvim rofi starship.toml waybar)

cd "$REPO_ROOT" || exit 1

# Copy real files
for f in "${FILES[@]}"; do
    src="$CONFIG_ROOT/$f"
    dest="$REPO_ROOT/$f"
    if [ -d "$src" ]; then
        cp -r "$src" "$dest"
    elif [ -f "$src" ]; then
        cp "$src" "$dest"
    fi
done

git commit -m "Updated"
git push -u origin main
