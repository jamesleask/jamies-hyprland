# Jamie's Hyprland Config

A hacked together Hyprland desktop configuration for EndeavourOS with a sleek, thin menubar and not a
lot else. No idea what I was doing as I was learning as I went. If that sounds like something you would
like to install on your machine, go for it!

## Installation

### 1. Install Dependencies
#### Arch Linux

```bash
sudo pacman -S hyprland waybar wofi ttf-jetbrains-mono-nerd grim slurp wl-clipboard swaylock
paru -S ghostty
```

### 2. Run Installation Script

The easiest way to set up everything is using the provided installation script. This will install dependencies (Arch/AUR), backup existing configs, and deploy the new files.

```bash
chmod +x install.sh
./install.sh
```

### 3. Manual Installation (Optional)

If you prefer to move files manually:

```bash
# Clone or copy this repo
mkdir -p ~/.config/hypr ~/.config/waybar

# Hyprland config
cp hyprland.conf ~/.config/hypr/

# Waybar config
cp waybar/config.jsonc ~/.config/waybar/config
cp waybar/style.css ~/.config/waybar/

# Helper scripts
mkdir -p ~/.config/hypr/scripts
cp scripts/power-menu.sh ~/.config/hypr/scripts/
chmod +x ~/.config/hypr/scripts/power-menu.sh
```

### 4. Start Hyprland

Log out and select Hyprland from your display manager, or run:
```bash
Hyprland
```

## Keybindings

| Key | Action |
|-----|--------|
| `Super + Enter` | Launch ghostty |
| `Super + D` | App launcher (wofi) |
| `Super + Q` | Close window |
| `Super + 1-4` | Switch workspace |
| `Super + Shift + 1-4` | Move window to workspace |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Print` | Screenshot (select area) |
| `Super + Shift + E` | Exit Hyprland |

## Customization

- **Terminal**: Change `$terminal = ghostty` in `hyprland.conf`
- **Launcher**: Change `$menu = wofi --show drun` in `hyprland.conf`
- **Colors**: Edit `waybar/style.css` (uses Catppuccin Mocha palette)
- **More quick launchers**: Add modules in `waybar/config.jsonc` under `modules-left`
