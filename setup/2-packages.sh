#!/bin/bash

setup_packages_basic_tools() {
  echo -e "\n[*] 2.1. Installing basic packages and yay\n"
  set -e

  # Install basic packages
  sudo pacman -Sy --noconfirm
  sudo pacman -S --noconfirm --needed \
    base-devel \
    curl \
    git

  # Install yay
  rm -rf /tmp/yay 2>/dev/null
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay
  makepkg -si --noconfirm

  rm -rf /tmp/yay 2>/dev/null
}

setup_packages() {
  echo -e "\n[*] 2.2. Installing packages\n"
  set -e

  # Hyprland and desktop environment
  sudo pacman -S --noconfirm \
    brightnessctl \
    ffmpeg \
    gnome-keyring \
    gvfs \
    gvfs-smb \
    hypridle hyprlock hyprpaper hyprpolkitagent \
    ly \
    nautilus \
    noto-fonts-emoji \
    openssh \
    pass \
    polkit-kde-agent \
    power-profiles-daemon \
    slurp \
    smartmontools \
    vdirsyncer \
    uv \
    waybar

  yay -S --noconfirm \
    elephant elephant-calc elephant-clipboard elephant-desktopapplications elephant-symbols elephant-unicode \
    swayosd-git \
    walker \
    wl-clipboard

  # TUIs
  sudo pacman -S --noconfirm \
    7zip \
    bluetui \
    bluez \
    bluez-utils \
    bottom \
    curl \
    duf \
    fastfetch \
    fx \
    glow \
    gum \
    khal \
    presenterm \
    wiremix \
    yazi \
    yt-dlp \
    zsh

  yay -S --noconfirm \
    gtt-bin \
    fresh-editor-bin \
    hostctl-bin

  uv tool install --force \
    git+https://github.com/llistochek/yandex-music-downloader

  # Development
  sudo pacman -S --noconfirm \
    aichat \
    composer \
    docker docker-compose \
    go gopls gobject-introspection \
    helm \
    jq \
    k9s \
    kubectl \
    openconnect \
    php \
    pritunl-client

  yay -S --noconfirm \
    go-task \
    migrate \
    posting-bin \
    tiny-rdm-bin

  curl -fsSL https://cli.coderabbit.ai/install.sh | sh

  # Apps
  sudo pacman -S --noconfirm \
    chromium \
    firefox \
    vlc vlc-plugin-ffmpeg

  yay -S --noconfirm \
    hiddify-app-bin \
    localsend-bin \
    obs-studio \
    parsec-bin \
    telegram-desktop \
    visual-studio-code-bin
}