#!/bin/bash

# Create symlinks for configs

setup_symlinks() {
  echo -e "\n[*] 1. Configuring symlinks\n"
  set -e

  local workspace_dir="$1"
  mkdir -p ~/.config

  # GUI
  ln -sfn "$workspace_dir/configs/gui/swayosd" ~/.config/swayosd
  ln -sfn "$workspace_dir/configs/gui/walker" ~/.config/walker
  ln -sfn "$workspace_dir/configs/gui/waybar" ~/.config/waybar

  # Apps
  ln -sfn "$workspace_dir/configs/apps/aichat" ~/.config/aichat
  ln -sfn "$workspace_dir/configs/apps/khal" ~/.config/khal
  ln -sfn "$workspace_dir/configs/apps/kitty" ~/.config/kitty
  ln -sfn "$workspace_dir/configs/apps/posting" ~/.config/posting
  ln -sfn "$workspace_dir/configs/apps/vdirsyncer" ~/.config/vdirsyncer

  # Dotfiles
  ln -sfn "$workspace_dir/configs/dotfiles/.coderabbit.yaml" ~/.coderabbit.yaml
  ln -sfn "$workspace_dir/configs/dotfiles/.gitignore-global" ~/.gitignore
  ln -sfn "$workspace_dir/configs/dotfiles/.inputrc" ~/.inputrc
  ln -sfn "$workspace_dir/configs/dotfiles/.nanorc" ~/.nanorc
  touch "$workspace_dir/configs/dotfiles/.netrc"
  ln -sfn "$workspace_dir/configs/dotfiles/.netrc" ~/.netrc
  ln -sfn "$workspace_dir/configs/dotfiles/.wakatime.cfg" ~/.wakatime.cfg

  # System
  sudo mkdir -p /etc/ly
  sudo ln -sfn "$workspace_dir/configs/system/ly/config.ini" /etc/ly/config.ini
}
