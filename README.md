# Dot Files

This repository contains dotfiles for my linux system. It contains configurations for the following:
1. hyprland (hyprpaper, hyprsunset, hyprlock, hypridle, hyprshot)
1. waybar
1. nvim
1. alacritty
1. kanata

## Required Packages
```bash
sudo pacman -S alacritty nvim waybar hyprland hyprsunset hypridle hyprlock hyprpolkitagent kanata stow
```

For synth shell follow installation steps at [synthshell github repository](https://github.com/andresgongora/synth-shell)

## Setting configurations
```bash
stow <pkg-name>
# Example: stow alacritty
```
