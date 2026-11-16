#!/bin/bash

# Load waybar in background with nohup
nohup waybar -c ~/.config/waybar/config-laptop.json -s ~/.config/waybar/style-laptop.css >/dev/null 2>&1 &
nohup waybar -c ~/.config/waybar/config-external.json -s ~/.config/waybar/style-external.css >/dev/null 2>&1 &
