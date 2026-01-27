# Jamie's Hyprland Config

A hacked together Hyprland desktop configuration for EndeavourOS with a sleek, thin menubar and not a
lot else. No idea what I was doing as I was learning as I went. If that sounds like something you would
like to install on your machine, go for it!

## Installation

### Run Arch Installation Script (Automatic)

The easiest way to set up everything is using the provided installation script. This will install dependencies (Arch/AUR), backup existing configs, and deploy the new files.

```bash
chmod +x install.sh
./install.sh
```

### Manual Installation

#### 1. Install Dependencies

##### Arch Linux

```bash
sudo pacman -S hyprland waybar rofi-wayland ttf-jetbrains-mono-nerd grim slurp wl-clipboard swaylock
paru -S ghostty
```

##### Manual

```bash
# Ensure config exists
mkdir -p ~/.config

# Copy all config folders
cp -r hypr waybar rofi wlogout ~/.config/

# Fix waybar config name
mv ~/.config/waybar/config.jsonc ~/.config/waybar/config
```

#### Start Hyprland

Log out and select Hyprland from your display manager, or run:
```bash
Hyprland
```

## Keybindings

| Key | Action |
|-----|--------|
| `Super + Enter` | Launch ghostty |
| `Super + D` | App launcher (rofi) |
| `Super + Q` | Close window |
| `Super + 1-4` | Switch workspace |
| `Super + Shift + 1-4` | Move window to workspace |
| `Super + F` | Fullscreen |
| `Super + V` | Toggle floating |
| `Print` | Screenshot (select area) |
| `Super + Shift + E` | Exit Hyprland |

## Customization

- **Keyboard mappings**: Edit `hypr/hyprland.conf` see `kb_layout=`
- **Terminal**: Change `$terminal = ghostty` in `hypr/hyprland.conf`
- **Launcher**: Rofi is configured in `rofi/`
- **Colors**: Edit `waybar/style.css` and `rofi/theme.rasi` (uses Catppuccin Mocha palette)
- **More quick launchers**: Add modules in `waybar/config.jsonc` under `modules-left`