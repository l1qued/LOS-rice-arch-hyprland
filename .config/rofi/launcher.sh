#!/bin/bash

SCRIPTS_DIR="$HOME/.config/rofi/scripts" 
CONFIG_FILE="$HOME/.config/rofi-opener.conf"

if [[ -f "$CONFIG_FILE" ]]; then
    SCRIPTS_DIR=$(cat "$CONFIG_FILE")
fi

if [[ ! -d "$SCRIPTS_DIR" ]]; then
    SCRIPTS_DIR="$HOME"
fi

show_scripts() {
    find "$SCRIPTS_DIR" -type f \( -perm -u=x -o -name "*.sh" \) ! -name ".*" 2>/dev/null | \
    while read -r script; do
        if [[ "$script" == "$SCRIPTS_DIR"/* ]]; then
            echo "${script#$SCRIPTS_DIR/}"
        else
            echo "$script"
        fi
    done
}

script_list=$(show_scripts)

if [[ -z "$script_list" ]]; then
    echo "Скрипты не найдены в: $SCRIPTS_DIR" | rofi -dmenu -p "Ошибка"
    
    new_dir=$(echo "$HOME" | rofi -dmenu -p "Введите путь к папке со скриптами")
    
    if [[ -n "$new_dir" ]]; then
        mkdir -p "$new_dir"
        echo "$new_dir" > "$CONFIG_FILE"
        SCRIPTS_DIR="$new_dir"
        script_list=$(show_scripts)
    fi
fi

selected=$(echo "$script_list" | rofi -dmenu -p "🚀 Выберите скрипт" -i)

if [[ -n "$selected" ]]; then
    if [[ "$selected" == /* ]]; then
        script_path="$selected"
    else
        script_path="$SCRIPTS_DIR/$selected"
    fi
    
    if [[ -f "$script_path" ]]; then
        chmod +x "$script_path" 2>/dev/null
        
        "$script_path"
    else
        echo "Файл не найден: $script_path" | rofi -dmenu -p "Ошибка"
    fi
fi
