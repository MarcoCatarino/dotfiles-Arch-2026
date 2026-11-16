#!/usr/bin/env bash

ROFI_SCRIPTS="/home/developer/.config/rofi/scripts"
WAYBAR_SCRIPTS="/home/developer/.config/waybar/scripts"
ROFI_CONFIG="/home/developer/.config/rofi/config.rasi"
HYPR_SCRIPTS="/home/developer/.config/hypr/scripts"

# Route bine rofi
ROFI_BIN="/usr/bin/rofi"

OPC_WALLPAPER="󰸉  Switch Backgrounds"
OPC_COLORES="󰏘  Switch Colors (Rofi)"
OPC_WAYBAR="󱛱  Switch Style (Waybar)"
OPC_AUDIO="󰋎  Switch Output Audio"
OPC_KEYBOARD="  Switch Keyboard"

menu() {
    printf "%s\n" "$OPC_WALLPAPER"
    printf "%s\n" "$OPC_WAYBAR"
    printf "%s\n" "$OPC_COLORES"
    printf "%s\n" "$OPC_KEYBOARD"
    printf "%s\n" "$OPC_AUDIO"
}

main() {
    # Use routes from Rofi
    choice=$(menu | $ROFI_BIN -dmenu -config "$ROFI_CONFIG" -p "Ajustes")

    case "$choice" in
        "$OPC_WALLPAPER")
            "$ROFI_SCRIPTS/wallpaperSelect.sh"
            ;;
        "$OPC_WAYBAR")
            "$WAYBAR_SCRIPTS/waybarStyles.sh"
            ;;
        "$OPC_COLORES")
            "$ROFI_SCRIPTS/themeSelect.sh"
            ;;
        "$OPC_AUDIO")
            "$ROFI_SCRIPTS/audioOutputSelect.sh"
            ;;
        "$OPC_KEYBOARD")
            "$HYPR_SCRIPTS/keyboardToggle.sh"
            ;;
            *)
            exit 0
            ;;
    esac
}

if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main