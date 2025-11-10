#!/bin/bash

THEMES_DIR="$HOME/.config/waybar"
CURRENT_THEME=$(basename $(readlink "$THEMES_DIR/style.css" | xargs dirname))

THEMES=($(ls "$THEMES_DIR/styles/"))

SELECTED_THEME=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p "Выберите тему" -selected-row $(for i in "${!THEMES[@]}"; do if [[ "${THEMES[$i]}" == "$CURRENT_THEME" ]]; then echo $i; break; fi; done))

if [[ -n "$SELECTED_THEME" && -d "$THEMES_DIR/styles/$SELECTED_THEME" ]]; then
    rm -f "$THEMES_DIR/style.css" "$THEMES_DIR/config.jsonc"
    
    ln -s "$THEMES_DIR/styles/$SELECTED_THEME/style.css" "$THEMES_DIR/style.css"
    ln -s "$THEMES_DIR/styles/$SELECTED_THEME/config.jsonc" "$THEMES_DIR/config.jsonc"
    
    killall waybar
    waybar &
    
    notify-send "Waybar Theme" "Тема изменена на: $SELECTED_THEME"
fi
