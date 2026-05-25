#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# 1. Definir rutas exactas de tu sistema
waybar_colors="$HOME/.config/waybar/colors"
waybar_style="$HOME/.config/waybar/style.css"
# Apuntamos a tu config base unificado (el de Zero Two)
rofi_config="$HOME/.config/rofi/config.rasi"

# Función para listar los estilos .css disponibles
menu() {
    options=()
    while IFS= read -r file; do
        if [ -f "$waybar_colors/$file" ]; then
            options+=("$(basename "$file" .css)")
        fi
    done < <(find "$waybar_colors" -maxdepth 1 -type f -name '*.css' -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Aplicar el estilo mediante un enlace simbólico flexible
apply_style() {
    ln -sf "$waybar_colors/$1.css" "$HOME/.config/waybar/current-theme.css"
    restart_waybar
}

# Reiniciar Waybar para aplicar los colores en caliente
restart_waybar() {
    if pgrep -x "waybar" >/dev/null; then
        pkill waybar
        sleep 0.1
    fi
    waybar &
}

# Función Principal
main() {
    # Usamos tu config base y le añadimos el prompt "-p Waybar" para estética
    choice=$(menu | rofi -dmenu -config "$rofi_config" -p "Waybar")

    if [[ -z "$choice" ]]; then
        echo "No se seleccionó ningún estilo. Saliendo."
        exit 0
    fi

    apply_style "$choice"
}

# Evitar duplicados de Rofi
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main
