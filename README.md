# Jamie's Hyprland Config

A modern Hyprland desktop configuration for EndeavourOS with a sleek, thin menubar.

## Bar Layout

```
[Menu] | [Terminal] | [Active Windows]     [ 1  2  3  4 ]     [Tray] | [🛜 🔊 🔋 🕐] | [⏻]
└─────────── Left ───────────┘           └── Center ──┘      └────────── Right ──────────┘
```

## Installation

### 1. Install Dependencies
#### Arch Linux

```bash
sudo pacman -S hyprland waybar wofi ttf-jetbrains-mono-nerd grim slurp wl-clipboard swaylock
paru -S ghostty
```

### 2. Deploy Configuration

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

### 3. Start Hyprland

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
