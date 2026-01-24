#!/bin/bash

# Jamie's Hyprland Install Script
# Sets up dependencies and configuration files

set -e

# --- Configuration ---
CONFIG_DIR="$HOME/.config"
HYPR_DIR="$CONFIG_DIR/hypr"
WAYBAR_DIR="$CONFIG_DIR/waybar"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX=".bak_$(date +%Y%m%d_%H%M%S)"

# --- Helper Functions ---
print_step() {
    echo -e "\n\e[1;34m>>> $1\e[0m"
}

print_success() {
    echo -e "\e[1;32mDONE: $1\e[0m"
}

backup_if_exists() {
    if [ -d "$1" ]; then
        echo "Backing up existing directory: $1 to $1$BACKUP_SUFFIX"
        mv "$1" "$1$BACKUP_SUFFIX"
    elif [ -f "$1" ]; then
        echo "Backing up existing file: $1 to $1$BACKUP_SUFFIX"
        mv "$1" "$1$BACKUP_SUFFIX"
    fi
}

# --- Check Environment ---
print_step "Checking environment..."
if ! command -v pacman &> /dev/null; then
    echo "Error: This script is intended for Arch Linux (pacman not found)."
    exit 1
fi

# --- Install Dependencies ---
print_step "Installing base dependencies..."
sudo pacman -S --needed --noconfirm \
    hyprland \
    waybar \
    rofi-wayland \
    ttf-jetbrains-mono-nerd \
    grim \
    slurp \
    wl-clipboard \
    swaylock

# --- Install AUR Dependencies ---
print_step "Installing AUR dependencies (ghostty)..."
if command -v paru &> /dev/null; then
    AUR_HELPER="paru"
elif command -v yay &> /dev/null; then
    AUR_HELPER="yay"
else
    echo "No AUR helper (paru/yay) found. Please install ghostty manually."
    AUR_HELPER=""
fi

if [ -n "$AUR_HELPER" ]; then
    $AUR_HELPER -S --needed --noconfirm ghostty
fi

# --- Deploy Configuration ---
print_step "Deploying configuration files..."

# Create target directories
mkdir -p "$HYPR_DIR"
mkdir -p "$WAYBAR_DIR"
mkdir -p "$HYPR_DIR/scripts"
mkdir -p "$CONFIG_DIR/rofi"

# Hyprland
backup_if_exists "$HYPR_DIR/hyprland.conf"
cp "$REPO_DIR/hyprland.conf" "$HYPR_DIR/"

# Waybar
backup_if_exists "$WAYBAR_DIR/config"
backup_if_exists "$WAYBAR_DIR/style.css"
cp "$REPO_DIR/waybar/config.jsonc" "$WAYBAR_DIR/config"
cp "$REPO_DIR/waybar/style.css" "$WAYBAR_DIR/"

# Rofi
backup_if_exists "$CONFIG_DIR/rofi/config.rasi"
backup_if_exists "$CONFIG_DIR/rofi/theme.rasi"
cp "$REPO_DIR/rofi/config.rasi" "$CONFIG_DIR/rofi/"
cp "$REPO_DIR/rofi/theme.rasi" "$CONFIG_DIR/rofi/"

# Scripts
cp "$REPO_DIR/scripts/power-menu.sh" "$HYPR_DIR/scripts/"
chmod +x "$HYPR_DIR/scripts/power-menu.sh"

print_success "Configurations deployed."

print_step "Installation complete!"
echo "You can now log out and select Hyprland from your display manager."
