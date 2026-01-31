#!/bin/bash

if [[ $EUID -eq 0 ]] || [[ $(id -u) -lt 1000 ]] || [[ -n "$SUDO_USER" ]]; then
  echo -e "\n[!] Run this script as non-root, non-system user, and don't use sudo"
  exit 1
fi

workspace_dir=$PWD
lockfiles_dir="$workspace_dir/.lockfiles"
mkdir -p "$lockfiles_dir"

if [ -f "$lockfiles_dir/completed.lock" ]; then
  echo -e "\n[*] Setup script was already completed"
  exit 0
fi

source "$workspace_dir/setup/1-symlinks.sh"
source "$workspace_dir/setup/2-packages.sh"
source "$workspace_dir/setup/3-post-install.sh"  read

source "$workspace_dir/setup/helpers.sh"

clear
cat "$workspace_dir/setup/ascii.art"
echo
echo "################ Starting workspace setup script ################"
echo
echo "  Workspace directory: $workspace_dir"
echo
echo "#################################################################"
echo

if ! ask "Continue?" "n"; then
  echo "Workspace setup canceled"
  exit 0
fi

if ! sudo -v; then
  echo -e "\n[!] Setup script needs root access to install packages and perform some additional operations"
  exit 1
fi
( while true; do sudo -v; sleep 60; done ) &
SUDO_PID=$!
trap "kill $SUDO_PID" EXIT

# Calling setup functions

if [ ! -f "$lockfiles_dir/symlinks.lock" ] && ! setup_symlinks "$workspace_dir"; then
  echo "[!] Can't configure symlinks" >&2
  exit 1
fi
touch "$lockfiles_dir/symlinks.lock"

if [ ! -f "$lockfiles_dir/packages-basic-tools.lock" ] && ! setup_packages_basic_tools; then
  echo "[!] Can't install basic tools packages" >&2
  exit 1
fi
touch "$lockfiles_dir/packages-basic-tools.lock"

if [ ! -f "$lockfiles_dir/packages.lock" ] &&  ! setup_packages; then
  echo "[!] Can't install packages" >&2
  exit 1
fi
touch "$lockfiles_dir/packages.lock"

if [ ! -f "$lockfiles_dir/post-install-zsh.lock" ] && ! setup_post_install_zsh; then
  echo "[!] Can't install ohmyzsh or configure zsh" >&2
  exit 1
fi
touch "$lockfiles_dir/post-install-zsh.lock"

if [ ! -f "$lockfiles_dir/post-install-systemd.lock" ] && ! setup_post_install_systemd; then
  echo "[!] Can't configure systemd services" >&2
  exit 1
fi
touch "$lockfiles_dir/post-install-systemd.lock"

if [ ! -f "$lockfiles_dir/post-install-hyprland.lock" ] && ! setup_post_install_hyprland; then
  echo "[!] Can't configure hyprland" >&2
  exit 1
fi
touch "$lockfiles_dir/post-install-hyprland.lock"

# As final step, create symlink on configs for hyprland ecosystem

ln -sfn "$workspace_dir/configs/gui/hypr" ~/.config/hypr
hyprctl reload

touch "$lockfiles_dir/completed.lock"

echo
echo "############## Setup script completed successfully ##############"
echo

if ask "Do you want to reboot system now?" "n"; then
  systemctl reboot
fi

exit 0
