#!/usr/bin/env bash
# Thanks https://github.com/JaKooLit ! #

set -euo pipefail
IFS=$'\n\t'

# Define directories
waybar_themes="~/.config/waybar/themes"
waybar_config="~/.config/waybar/config"
rofi_config="~/.config/rofi/themes/waybar-layout.rasi"

# Display menu options
menu() {
    options=()
    while IFS= read -r file; do
        options+=("$(basename "$file")")
    done < <(find "$waybar_themes" -maxdepth 1 -type f -exec basename {} \; | sort)

    printf '%s\n' "${options[@]}"
}

# Apply selected configuration
apply_config() {
    ln -sf "$waybar_themes/$1" "$waybar_config"
    restart_waybar_if_needed
}

# Restart Waybar
restart_waybar_if_needed() {
    if pgrep -x "waybar" >/dev/null; then
        pkill waybar
        sleep 0.1
    fi
    ./refresh.sh &
}

# Main function
main() {
    choice=$(menu | rofi -dmenu -config "$rofi_config")

    if [[ -z "$choice" ]]; then
        echo "No option selected. Exiting."
        exit 0
    fi

    case $choice in
        "no panel")
            pgrep -x "waybar" && pkill waybar || true
            ;;
        *)
            apply_config "$choice"
            ;;
    esac
}

# Kill Rofi if already running before execution
if pgrep -x "rofi" >/dev/null; then
    pkill rofi
    exit 0
fi

main