#!/bin/bash

setup_post_install_zsh() {
  echo -e "\n[*] 3.1. Configuring zsh and ohmyzsh\n"
  set -e

  local workspace_dir="$1"

  # Installing ohmyzsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  chsh -s "$(which zsh)"

  # Configuring symlinks
  rm -f ~/.zshrc ~/.zshenv
  ln -s "$workspace_dir/configs/dotfiles/.zshrc" ~/.zshrc
  ln -s "$workspace_dir/configs/dotfiles/.zshenv" ~/.zshenv
  ln -sfn "$workspace_dir/configs/dotfiles/.p10k.zsh" ~/.p10k.zsh

  # Put WORKSPACE_DIR in .zshenv
  escaped_workspace_dir=$(echo "$workspace_dir" | sed 's/\//\\\//g')
  if grep -q "^WORKSPACE_DIR=" ~/.zshenv 2>/dev/null; then
      sed -i "s/^WORKSPACE_DIR=.*/WORKSPACE_DIR=\"$escaped_workspace_dir\"/" ~/.zshenv
  else
      echo "WORKSPACE_DIR=\"$workspace_dir\"" >> ~/.zshenv
  fi

  # Clone Powerlevel10k zsh theme
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
}

setup_post_install_systemd() {
  echo -e "\n[*] 3.2. Configuring systemd services\n"
  set -e

  chmod +x ~/.xinitrc
  sudo systemctl enable ly.service
  sudo systemctl start ly.service
}

setup_post_install_hyprland() {
    echo -e "\n[*] 3.3. Configuring hyprland\n"
    set -e

    hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
    hyprpm enable split-monitor-workspaces
    hyprpm reload
}