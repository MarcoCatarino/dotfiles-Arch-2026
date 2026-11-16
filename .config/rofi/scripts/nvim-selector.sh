#!/bin/bash

BASE_DIR="$HOME"

# Rofi not return select
if [ -n "$1" ]; then
    FULL_PATH="$BASE_DIR/$1"
    
    # Ghostty in background and decouple script to instantly close Rofi
    ghostty -e nvim -c "cd $FULL_PATH" "$FULL_PATH" > /dev/null 2>&1 & 
    disown
else
    # Format labels
    fd --max-depth 3 --hidden --exclude .git . --base-directory "$BASE_DIR"
fi