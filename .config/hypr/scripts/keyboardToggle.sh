#!/usr/bin/env bash

ROFI_CONFIG="/home/developer/.config/rofi/config.rasi"
ROFI_BIN="/usr/bin/rofi"

# 1. Obtener los layouts configurados en Hyprland
layouts_str=$(hyprctl getoption input:kb_layout -j | jq -r '.str')

if [ -z "$layouts_str" ]; then
    notify-send "Teclado" "No se pudieron obtener los layouts." -t 1500
    exit 1
fi

declare -A lang_map
menu_array=()
IFS=',' read -ra layouts <<< "$layouts_str"

# 2. Construir el array limpio sin espacios sobrantes
for i in "${!layouts[@]}"; do
    lang="${layouts[$i]}"
    display_text="󰌌   Idioma: $lang"
    menu_array+=("$display_text")
    lang_map["$display_text"]="$i"
done

# Convertir el array a texto de forma estricta elemento por elemento
menu_options=$(printf "%s\n" "${menu_array[@]}")

# 3. Mostrar el menú en Rofi
chosen=$(echo "$menu_options" | $ROFI_BIN -dmenu -config "$ROFI_CONFIG" -p "Idioma Teclado")

# 4. Aplicar el cambio usando el mapa interno
if [ -n "$chosen" ]; then
    index="${lang_map["$chosen"]}"
    if [ -n "$index" ]; then
        hyprctl switchxkblayout all "$index"
        notify-send "Teclado" "Cambiado a: ${layouts[$index]}" -t 1500
    fi
fi
