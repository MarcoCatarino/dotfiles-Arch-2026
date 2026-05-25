#!/usr/bin/env bash
#中心 - Script Maestro de Personalización Unificado

ROFI_SCRIPTS="/home/developer/.config/rofi/scripts"
WAYBAR_SCRIPTS="/home/developer/.config/waybar/scripts"
ROFI_CONFIG="/home/developer/.config/rofi/config.rasi"
# Ruta absoluta al binario de rofi
ROFI_BIN="/usr/bin/rofi"

OPC_WALLPAPER="󰸉  Cambiar Fondo de Pantalla"
OPC_COLORES="󰏘  Cambiar Colores de Rofi"
OPC_WAYBAR="󱛱  Cambiar Estilo de Waybar"

menu() {
    printf "%s\n" "$OPC_WALLPAPER"
    printf "%s\n" "$OPC_WAYBAR"
    printf "%s\n" "$OPC_COLORES"
}

main() {
    # Forzamos el uso de la ruta absoluta de Rofi
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
