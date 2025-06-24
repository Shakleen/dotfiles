# Dot Files

This repository contains dotfiles for my linux system. It contains configurations for the following:
1. hyprland (hyprpaper, hyprsunset, hyprlock, hypridle, hyprshot)
1. waybar
1. nvim
1. alacritty
1. kanata
1. tmux

## Required Packages
```bash
sudo pacman -S alacritty nvim waybar hyprland hyprsunset hypridle hyprlock hyprpolkitagent kanata stow tmux
```

### Synth-shell
For synth shell follow installation steps at [synthshell github repository](https://github.com/andresgongora/synth-shell)

### Tmux Plugin Manager
Follow installation for tmux pugin manager at [TPM](https://github.com/tmux-plugins/tpm)

### Diff so Fancy
Install diff so fancy [repository](https://github.com/so-fancy/diff-so-fancy)

## Setting configurations
```bash
stow <pkg-name>
# Example: stow alacritty
```
