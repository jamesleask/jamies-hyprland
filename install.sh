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
    wlogout \
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

# Create target config directory
mkdir -p "$CONFIG_DIR"

# Iterate over directories in REPO_DIR
# Exclude .git and scripts
for dir in "$REPO_DIR"/*/; do
    dir_name=$(basename "$dir")
    
    # Skip .git and scripts (scripts are handled separately)
    if [[ "$dir_name" == ".git" || "$dir_name" == "scripts" ]]; then
        continue
    fi
    
    target_dir="$CONFIG_DIR/$dir_name"
    
    print_step "Deploying $dir_name to $target_dir..."
    backup_if_exists "$target_dir"
    cp -r "$dir" "$CONFIG_DIR/"
    
    # Rename config.jsonc to config for waybar if it exists in the target
    if [[ "$dir_name" == "waybar" && -f "$target_dir/config.jsonc" ]]; then
        mv "$target_dir/config.jsonc" "$target_dir/config"
    fi
done

# Handle scripts separately
if [ -d "$REPO_DIR/scripts" ]; then
    print_step "Deploying scripts..."
    mkdir -p "$HYPR_DIR/scripts"
    cp -r "$REPO_DIR/scripts/"* "$HYPR_DIR/scripts/"
    chmod +x "$HYPR_DIR/scripts/"*.sh
fi

print_success "Configurations deployed."

print_step "Installation complete!"
echo "You can now log out and select Hyprland from your display manager."
