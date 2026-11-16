#!/usr/bin/env bash

ROFI_CONFIG="/home/developer/.config/rofi/config.rasi"
ROFI_BIN="/usr/bin/rofi"

declare -A sink_map
menu_array=()

# Get Data & Save in array
while IFS=$'\t' read -r idx name desc; do
    if [ -n "$desc" ] && [ -n "$name" ]; then
        menu_array+=("$desc")
        sink_map["$desc"]="$name"
    fi
done < <(pactl list sinks | awk '
    /^Sink #[0-9]+/ { id=$2; gsub("#", "", id) }
    /Name:/ { name=$2 }
    /Description:/ { 
        $1=""; sub(/^ /, ""); desc=$0; 
        if (desc != "") print id "\t" name "\t" desc 
    }
')

if [ ${#menu_array[@]} -eq 0 ]; then
    notify-send "Audio" "No se encontraron dispositivos de salida." -t 1500
    exit 1
fi

# Format labels
menu_options=$(printf "%s\n" "${menu_array[@]}")

# Menu Rofi
chosen=$(echo "$menu_options" | $ROFI_BIN -dmenu -config "$ROFI_CONFIG" -p "Salida de Audio")

# Applied after select
if [ -n "$chosen" ]; then
    target_sink="${sink_map["$chosen"]}"
    if [ -n "$target_sink" ]; then
        pactl set-default-sink "$target_sink"

        for input in $(pactl list short sink-inputs | awk '{print $1}'); do
            pactl move-sink-input "$input" "$target_sink" 2>/dev/null
        done

        notify-send "Audio Output" "Cambiado a: $chosen" -t 1500
    fi
fi