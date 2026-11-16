#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# 1. Define routes
waybar_colors="$HOME/.config/waybar/colors"
waybar_style="$HOME/.config/waybar/style.css"
rofi_config="$HOME/.config/rofi/config.rasi"

# List CSS
menu() {
    options=()
    while IFS= read -r file; do
        if [ -f "$waybar_colors/$file" ]; then
            options+=("$(basename "$file" .css)")
        fi
    done < <(find "$waybar_colors" -maxdepth 1 -type f -name '*.css' -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Applied style
apply_style() {
    ln -sf "$waybar_colors/$1.css" "$HOME/.config/waybar/current-theme.css"
    restart_waybar
}

# Reload Waybar
restart_waybar() {
    if pgrep -x "waybar" >/dev/null; then
        pkill waybar
        sleep 0.1
    fi
    waybar &
}

main() {
    # Use base config and add "-p Waybar"
    choice=$(menu | rofi -dmenu -config "$rofi_config" -p "Waybar")

    if [[ -z "$choice" ]]; then
        echo "No se seleccionó ningún estilo. Saliendo."
        exit 0
    fi

    apply_style "$choice"
}

# Reduce duplicate Rofi
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main