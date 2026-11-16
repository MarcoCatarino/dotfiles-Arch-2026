#!/usr/bin/env bash
# Selector de Paletas Rofi

rofi_colors="/home/developer/.config/rofi/colors"
current_theme="/home/developer/.config/rofi/current-theme.rasi"
rofi_config="/home/developer/.config/rofi/config.rasi"
ROFI_BIN="/usr/bin/rofi"

menu() {
    find "$rofi_colors" -maxdepth 1 -type f -name '*.rasi' -exec basename {} .rasi \; | sort
}

main() {
    choice=$(menu | $ROFI_BIN -dmenu -config "$rofi_config" -p "Paletas")

    if [[ -n "$choice" ]]; then
        ln -sf "$rofi_colors/$choice.rasi" "$current_theme"
    fi
}

main