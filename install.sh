#!/bin/bash

# =============================================
# Oreo Rice Installer
# Creator: @l1queds
# =============================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' 

SPINNER=('⣷' '⣯' '⣟' '⡿' '⢿' '⣻' '⣽' '⣾')
DOTS=('.  ' '.. ' '...')

declare -A messages

set_language() {
    clear
    echo -e "${PURPLE}"
    echo -e " ██████╗ ██████╗ ███████╗ ██████╗ "
    echo -e "██╔═══██╗██╔══██╗██╔════╝██╔═══██╗"
    echo -e "██║   ██║██████╔╝█████╗  ██║   ██║"
    echo -e "██║   ██║██╔══██╗██╔══╝  ██║   ██║"
    echo -e "╚██████╔╝██║  ██║███████╗╚██████╔╝"
    echo -e " ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝"
    echo -e "${CYAN}     Oreo Rice Installer${NC}"
    echo -e "${YELLOW}        Contact: @l1queds${NC}"
    echo -e "=========================================="
    echo -e ""
    echo -e "${CYAN}Select language / Выберите язык:${NC}"
    echo -e "  ${WHITE}1. English${NC}"
    echo -e "  ${WHITE}2. Русский${NC}"
    echo -e ""
    
    read -p "$(echo -e ${CYAN}"Choose (1/2): "${NC})" lang_choice
    
    case $lang_choice in
        1)
            messages=(
                ["title"]="Hyprland Rice Installer"
                ["contact"]="Contact: @l1queds"
                ["banner_title"]="This script will install and configure:"
                ["banner_item1"]="Hyprland window manager"
                ["banner_item2"]="Essential packages and dependencies"
                ["banner_item3"]="YAY AUR helper"
                ["banner_item4"]="Custom themes and configurations"
                ["banner_item5"]="Fish shell as default"
                ["warning"]="WARNING"
                ["warning_modify"]="This will modify your system configuration!"
                ["warning_backup"]="Make sure you have backed up your data!"
                ["continue"]="Do you want to continue? (y/N): "
                ["cancelled"]="Installation cancelled."
                ["warning_actions"]="The following actions will be performed:"
                ["action1"]="Install system packages with pacman"
                ["action2"]="Install and build YAY from GitHub"
                ["action3"]="Install AUR packages with YAY"
                ["action4"]="Download and install themes"
                ["action5"]="Change default shell to fish"
                ["action6"]="System will reboot after installation"
                ["confirm"]="Are you absolutely sure? (y/N): "
                ["starting"]="Starting installation process..."
                ["updating"]="Updating system and installing packages"
                ["cloning_yay"]="Cloning YAY repository"
                ["building_yay"]="Building and installing YAY"
                ["aur_packages"]="Installing AUR packages with YAY"
                ["themes"]="Downloading and installing themes"
                ["permissions"]="Setting executable permissions"
                ["changing_shell"]="Changing default shell to fish"
                ["shell_set"]="Setting fish as default shell"
                ["success"]="SUCCESS"
                ["completed"]="Installation completed successfully!"
                ["reboot_warning"]="System will reboot in 10 seconds..."
                ["cancel_hint"]="Press Ctrl+C to cancel reboot"
                ["rebooting"]="Rebooting now!"
                ["installing_packages"]="Installing pacman packages"
                ["installing_yay"]="Installing YAY AUR helper"
            )
            ;;
        2)
            messages=(
                ["title"]="Установщик Hyprland Rice"
                ["contact"]="Контакт: @l1queds"
                ["banner_title"]="Этот скрипт установит и настроит:"
                ["banner_item1"]="Оконный менеджер Hyprland"
                ["banner_item2"]="Основные пакеты и зависимости"
                ["banner_item3"]="AUR помощник YAY"
                ["banner_item4"]="Пользовательские темы и конфиги"
                ["banner_item5"]="Fish shell как основной"
                ["warning"]="ПРЕДУПРЕЖДЕНИЕ"
                ["warning_modify"]="Это изменит конфигурацию вашей системы!"
                ["warning_backup"]="Убедитесь, что сделали бэкап данных!"
                ["continue"]="Продолжить установку? (y/Н): "
                ["cancelled"]="Установка отменена."
                ["warning_actions"]="Будут выполнены следующие действия:"
                ["action1"]="Установка системных пакетов через pacman"
                ["action2"]="Установка и сборка YAY из GitHub"
                ["action3"]="Установка AUR пакетов через YAY"
                ["action4"]="Скачивание и установка тем"
                ["action5"]="Смена стандартной оболочки на fish"
                ["action6"]="Система перезагрузится после установки"
                ["confirm"]="Вы абсолютно уверены? (y/Н): "
                ["starting"]="Запуск процесса установки..."
                ["updating"]="Обновление системы и установка пакетов"
                ["cloning_yay"]="Клонирование репозитория YAY"
                ["building_yay"]="Сборка и установка YAY"
                ["aur_packages"]="Установка AUR пакетов через YAY"
                ["themes"]="Скачивание и установка тем"
                ["permissions"]="Выдача прав на выполнение"
                ["changing_shell"]="Смена стандартной оболочки на fish"
                ["shell_set"]="Установка fish как стандартной оболочки"
                ["success"]="УСПЕХ"
                ["completed"]="Установка успешно завершена!"
                ["reboot_warning"]="Перезагрузка через 10 секунд..."
                ["cancel_hint"]="Нажмите Ctrl+C для отмены перезагрузки"
                ["rebooting"]="Перезагружаемся!"
                ["installing_packages"]="Установка пакетов pacman"
                ["installing_yay"]="Установка AUR помощника YAY"
            )
            ;;
        *)
            echo -e "${RED}Invalid choice. Using English.${NC}"
            sleep 2
            set_language
            ;;
    esac
}

spinner() {
    local pid=$1
    local message=$2
    local i=0
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        printf "\r${CYAN}${SPINNER[$i]}${NC} ${message}   "
        sleep 0.1
    done
    printf "\r${GREEN}✓${NC} ${message}    \n"
}

dot_animation() {
    local message=$1
    for i in {1..3}; do
        printf "\r${PURPLE}▶${NC} ${message}${DOTS[$((i-1))]}"
        sleep 0.5
    done
    printf "\r${GREEN}▶${NC} ${message}...\n"
}

print_banner() {
    clear
    echo -e "${PURPLE}"
    echo -e " ██████╗ ██████╗ ███████╗ ██████╗ "
    echo -e "██╔═══██╗██╔══██╗██╔════╝██╔═══██╗"
    echo -e "██║   ██║██████╔╝█████╗  ██║   ██║"
    echo -e "██║   ██║██╔══██╗██╔══╝  ██║   ██║"
    echo -e "╚██████╔╝██║  ██║███████╗╚██████╔╝"
    echo -e " ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝"
    echo -e "${CYAN}     ${messages["title"]}${NC}"
    echo -e "${YELLOW}        ${messages["contact"]}${NC}"
    echo -e "=========================================="
    echo -e ""
}

print_warning() {
    echo -e "${YELLOW}╔══════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║           ${messages["warning"]}               ║${NC}"
    echo -e "${YELLOW}╚══════════════════════════════════════╝${NC}"
}

print_success() {
    echo -e "${GREEN}╔══════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              ${messages["success"]}               ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════╝${NC}"
}

# =============================================
# MAIN INSTALLATION SCRIPT
# =============================================

set_language

# =============================================
# CONFIRMATION SECTION
# =============================================

print_banner

echo -e "${CYAN}${messages["banner_title"]}${NC}"
echo -e "  ${WHITE}• ${messages["banner_item1"]}${NC}"
echo -e "  ${WHITE}• ${messages["banner_item2"]}${NC}"
echo -e "  ${WHITE}• ${messages["banner_item3"]}${NC}"
echo -e "  ${WHITE}• ${messages["banner_item4"]}${NC}"
echo -e "  ${WHITE}• ${messages["banner_item5"]}${NC}"
echo -e ""

print_warning
echo -e "${YELLOW}${messages["warning_modify"]}${NC}"
echo -e "${YELLOW}${messages["warning_backup"]}${NC}"
echo -e ""

read -p "$(echo -e ${CYAN}"${messages["continue"]}"${NC})" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}${messages["cancelled"]}${NC}"
    exit 1
fi

# =============================================
# WARNINGS SECTION
# =============================================

print_warning
echo -e "${YELLOW}${messages["warning_actions"]}${NC}"
echo -e "  ${RED}• ${messages["action1"]}${NC}"
echo -e "  ${RED}• ${messages["action2"]}${NC}"
echo -e "  ${RED}• ${messages["action3"]}${NC}"
echo -e "  ${RED}• ${messages["action4"]}${NC}"
echo -e "  ${RED}• ${messages["action5"]}${NC}"
echo -e "  ${RED}• ${messages["action6"]}${NC}"
echo -e ""

read -p "$(echo -e ${CYAN}"${messages["confirm"]}"${NC})" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}${messages["cancelled"]}${NC}"
    exit 1
fi

# =============================================
# INSTALLATION SECTION
# =============================================

echo -e ""
echo -e "${BLUE}${messages["starting"]}${NC}"
echo -e ""

# Установка пакетов pacman
dot_animation "${messages["installing_packages"]}"
sudo pacman -Syu --noconfirm hyprshot hyprpicker waybar swaync nwg-look swww hyprlock fish neovim papirus-icon-theme rofi pavucontrol vscode-css-languageserver ttf-font-awesome otf-font-awesome ttf-jetbrains-mono nerd-fonts nftables ttf-dejavu blueberry inetutils scrcpy thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman file-roller p7zip unrar tar tumbler ntfs-3g exfatprogs fuse2 fuse3 dosfstools gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb udisks2 gvfs-smb

# Копирование конфигов
cp -r .config/* ~/.config/
cp -r Wallpapers ~/

# Установка YAY
git clone https://aur.archlinux.org/yay.git /tmp/yay 

cd /tmp/yay
makepkg -si --noconfirm 
cd ..
# Установка пакетов YAY

yay -S --noconfirm neohtop zen-browser-bin emmet-language-server 

# Скачивание и установка тем
dot_animation "${messages["themes"]}"
git clone https://github.com/vinceliuice/Graphite-gtk-theme.git
chmod +x ./Graphite-gtk-theme/install.sh
chmod +x ./Graphite-gtk-theme/other/grub2/install.sh
./Graphite-gtk-theme/install.sh
./Graphite-gtk-theme/other/grub2/install.sh

# Выдача прав на выполнение скриптов

chmod +x ~/.config/swww/swww.sh 

# Смена shella
chsh -s /bin/fish 

# ============ КОНЕЦ ПОЛЬЗОВАТЕЛЬСКИХ ЭЛЕМЕНТОВ ============

# =============================================
# FINAL SECTION
# =============================================
echo -e ""
print_success
echo -e "${GREEN}${messages["completed"]}${NC}"
echo -e ""

print_warning
echo -e "${RED}${messages["reboot_warning"]}${NC}"
echo -e "${YELLOW}${messages["cancel_hint"]}${NC}"
echo -e ""

# Countdown animation
for i in {10..1}; do
    if [[ $lang_choice == "2" ]]; then
        printf "\r${RED}Перезагрузка через %2d секунд...${NC}" $i
    else
        printf "\r${RED}Rebooting in %2d seconds...${NC}" $i
    fi
    sleep 1
done

echo -e "\n${GREEN}${messages["rebooting"]}${NC}"
sleep 10

# Reboot system
reboot
