#!/bin/bash

# Color Codes
GREEN='\0333[1;32m'
CYAN='\0333[1;36m'
YELLOW='\0333[1;33m'
NC='\0333[0m'

THEME="$1"
THEME_DIR="$HOME/.config/colorschemas/$THEME"

if [ -z $THEME ]; then
  echo -e "${YELLOW}Usage $0 <theme-name>${NC}"
  exit 1
fi

if [ ! -d "$THEME_DIR" ];then
  echo -e "${YELLOW}Theme '$THEME' does not exist at $THEME_DIR${NC}"
  exit 1
fi

echo -e "${GREEN}Applying theme: $THEME${NC}\n"

# Hyprland LUA Config
echo -e "${CYAN}-> Updating Hyprland configuration...${NC}"
cp "$THEME_DIR/hypr/hyprland.conf" "$HOME/.config/hypr/hyprland.lua" > /dev/null 2>&1
echo ""

# Waybar Style
echo -e "${CYAN}-> Applying Waybar CSS...${NC}"
cp "$THEME_DIR/waybar/style.css" "$HOME/.config/waybar/main/style.css" > /dev/null 2>&1
echo -e "${CYAN}-> Restarting Waybar...${NC}"
pkill waybar > /dev/null 2&1 && ~/.config/waybar/scripts/launch.sh > /dev/null 2>&1 & disown
echo ""

# Wallpaper
echo -e "${CYAN}-> Setting Wallpaper...${NC}"
awww img "$THEME_DIR/wallpaper.jpg" --transition-type center --transition-fps 60 --transition-step 255 > /dev/null 2>&1
echo ""

# GTK THEME
if [ -f "$THEME_DIR/gtk-theme" ];then
  GTK_THEME_NAME=$(cat "$THEME_DIR/gtk-theme")
  echo -e "${CYAN}-> Setting GTK Theme to '$GTK_THEME_NAME'...${NC}"
  gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME_NAME" > /dev/null 2>&1
else
  echo -e "${YELLOW}-> GTK Theme File Not Found, Skipping.${NC}"
fi
echo ""

GTK4_SRC="$THEME_DIR/gtk-4.0"
GTK4_DST="$HOME/.config/gtk-4.0"

if [[ -d "$GTK4_SRC" ]];then
  echo -e "${CYAN}-> Linking GTK4 Theme Files...${NC}"
  mkdir -p "$GTK4_DST"
  ln -sf "$GTK4_SRC/gtk.css" "$GTK4_DST/gtk.css"
  ln -sf "$GTK4_SRC/gtk-dark.css" "$GTK4_DST/gtk-dark.css"
  ln -sfn "$GTK4_SRC/assets" "$GTK4_DST/assets"
else
  echo -e "${YELLOW}-> No GTK Theme Files Found in $GTK4_SRC. Skipping.${NC}"
fi 
echo ""

# Reload Hyprland Conf
echo -e "${CYAN}-> Reloading Hyprland Configuration...${NC}"
hyprctl reload & /dev/null 2>&1
echo ""

# Terminal Theme
echo -e "${CYAN}-> Applying Terminal Theme...${NC}"
case "$THEME" in
    catppuccin | everforest-dark)
        cp "$THEME_DIR/ghostty/colors.conf" "$HOME/.config/ghostty/colors.conf" > /dev/null 2 >&1
        ;;
    *)
        echo -e "${YELLOW}-> No Terminal Theme Defined fot $THEME. Skipping.${NC}"
        ;;
esac
kill -SIGUSR1 "$pgrep ghostty" > /dev/null 2>&1
echo ""

# SwayNC Theme 
echo -e "${CYAN}-> Applying SwayNC Theme...${NC}"
mkdir -p "$HOME/.local/share/rofi/materials-you"
cp "$THEME_DIR/rofi/themes/materials-you/materials-you.rasi" "$HOME/.local/share/rofi/themes/materials-you" > /dev/null 2>&1
cp "$THEME_DIR/rofi/themes/rounded/rounded-template.rasi" "$HOME/.local/share/rofi/themes/rounded/" > /dev/null 2>&1
echo ""

# NVChad Theme
echo -e "${CYAN}-> Applying NvChad Theme...${NC}"
cp "$THEME_DIR"/nvim/lua/chadrc.lua "$HOME/.config/nvim/lua"
echo ""

