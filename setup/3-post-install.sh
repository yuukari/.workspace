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

    local plugin_dir="$HOME/.local/share/hypr/plugins/split-monitor-workspaces"

    local repo_url="https://github.com/zjeffer/split-monitor-workspaces"

    mkdir -p "$(dirname "$plugin_dir")"

    # Recover from an interrupted previous clone: dir exists without .git
    if [ -d "$plugin_dir" ] && [ ! -d "$plugin_dir/.git" ]; then
        echo "[!] Incomplete plugin checkout found, removing $plugin_dir"
        rm -rf "$plugin_dir"
    fi

    if [ -d "$plugin_dir/.git" ]; then
        if ! git -C "$plugin_dir" fetch origin main; then
            echo "[!] Offline or fetch failed, keeping existing plugin checkout"
            return 0
        fi
        git -C "$plugin_dir" checkout main
        git -C "$plugin_dir" pull --ff-only origin main
    else
        git clone --depth=1 --branch main "$repo_url" "$plugin_dir"
    fi
}
