#!/bin/bash

WALLPAPERS_DIR="$HOME/Wallpapers"

chosen=$(find "$WALLPAPERS_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec basename {} \; | sort | wofi --dmenu --prompt "Wallpaper..." )

if [ -n "$chosen" ]; then
    full_path="$WALLPAPERS_DIR/$chosen"
    swww img "$full_path" --transition-step 7 
    notify-send "Wallpaper changed!" "$chosen"
fi
