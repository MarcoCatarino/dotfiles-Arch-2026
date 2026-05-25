#!/bin/bash

# Usamos 'fd' si lo tienes, o 'find' como alternativa para buscar archivos
# Filtramos para no buscar en .git o node_modules y evitar lentitud
FILE=$(fd --type f --hidden --exclude .git | rofi -dmenu -i -p "Abrir con Neovim:")

# Si seleccionaste algo, ábrelo en Ghostty
if [ -n "$FILE" ]; then
    ghostty -e nvim "$FILE"
fi
