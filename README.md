# .workspace

My personal workspace configs for archlinux, based on hyprland and various TUIs, including:

- Script for automatic installing on a fresh device with archlinux and preinstalled hyprland with basic config
- Preference for TUI over GUI applications
- [Utilities, development and session menus](#quick-menus) for quick access to frequent actions
- Installing and removing packages from pacman/AUR with search in terminal, inspired by [omarchy](https://omarchy.org/)
- Integrated [khal](https://github.com/pimutils/khal) application with events sync
  via [vdirsyncer](https://github.com/pimutils/vdirsyncer)
- Shows weather from [wttr.in](https://github.com/chubin/wttr.in)
- Safely passing sensitive data through password manager (pass) instead of plain-texting them in configs, .env's, etc

![Main preview](/.docs/preview.png)

> Wallpaper is some edited artwork of [safeheaven](https://www.safehavenhq.com/) for his incredible brand [ghosthardware](https://ghosthardware.net) 

## Installation

Just clone this repository and execute setup script:

```sh
git clone https://github.com/yuukari/.workspace.git
cd .workspace
./setup.sh
```

## What's included

<details> 
  <summary><h3>GUI and system</h3></summary>

| Component                                                                                            | Description                                   |
|------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| [ly](https://github.com/fairyglade/ly)                                                               | Display manager                               |
| [hyprland](https://github.com/hyprwm/Hyprland)                                                       | Desktop, window compositor                    |
| [hypridle](https://github.com/hyprwm/Hypridle)                                                       | IDLE daemon                                   |
| [hyprlock](https://github.com/hyprwm/Hyprlock)                                                       | Lockscreen                                    |
| [hyprpaper](https://github.com/hyprwm/hyprpaper)                                                     | Wallpaper manager                             |
| [waybar](https://github.com/Alexays/Waybar)                                                          | Status bar                                    |
| [walker](https://github.com/abenz1267/walker) with [elephant](https://github.com/abenz1267/elephant) | Applications launcher                         |
| [swayosd](https://github.com/ErikReider/SwayOSD)                                                     | OSD for changing volume/brightness            |
| [wl-clipboard](https://github.com/bugaevc/wl-clipboard)                                              | Command-line copy/paste utilities for Wayland |

</details>

<details>
  <summary><h3>Applications</h3></summary>

| Component                                                                                                                                                      | Description                      |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------|
| [zsh](https://github.com/zsh-users/zsh) with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme | Shell                            |
| [kitty](https://github.com/kovidgoyal/kitty)                                                                                                                   | Terminal emulator                |
| [yazi](https://github.com/sxyazi/yazi), [nautilus](https://gitlab.gnome.org/GNOME/nautilus)                                                                    | TUI and GUI file managers        |
| [fresh](https://github.com/sinelaw/fresh), [Visual Studio Code](https://code.visualstudio.com/)                                                                | TUI and GUI editors              |
| Chromium, Firefox                                                                                                                                              | Web browsers                     |
| [impala](https://github.com/pythops/impala)                                                                                                                    | Wi-Fi manager                    |
| [bluetui](https://github.com/pythops/bluetui)                                                                                                                  | Bluetooth manager                |
| [wiremix](https://github.com/tsowell/wiremix)                                                                                                                  | Audio control panel              |
| [bottom](https://github.com/ClementTsang/bottom)                                                                                                               | Process manager                  |
| [khal](https://github.com/pimutils/khal)                                                                                                                       | Calendar                         |
| [VLC](https://github.com/videolan/vlc)                                                                                                                         | Video player                     |
| [OBS studio](https://github.com/obsproject/obs-studio)                                                                                                         | Video recording                  |
| Telegram                                                                                                                                                       | Messenger                        |
| [Hiddify](https://github.com/hiddify/hiddify-app)                                                                                                              | Vless/X-ray proxy client         |
| [Parsec](https://parsec.app)                                                                                                                                   | Remote desktop client            |
| [LocalSend](https://github.com/localsend/localsend)                                                                                                            | Sharing files over local network |

</details>

<details>
  <summary><h3>Development toolchain</h3></summary>

| Component                                                                                                                                        | Description                                         |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| [aichat](https://github.com/sigoden/aichat)                                                                                                      | Interacting with LLMs via terminal                  |
| [Coderabbit CLI](https://www.coderabbit.ai/cli)                                                                                                  | AI reviewing                                        |
| Docker, Docker Compose                                                                                                                           | Containerization                                    |
| go, gopls, [go-task](https://github.com/go-task/task), [migrate](https://github.com/golang-migrate/migrate)                                      | Go programming language and toolchain               |
| helm                                                                                                                                             | Package manager for Kubernetes                      | 
| [k9s](https://github.com/derailed/k9s), kubectl                                                                                                  | TUI and CLI to interacting with Kubernetes clusters |
| [openconnect](https://archlinux.org/packages/extra/x86_64/openconnect/), [pritunl-client](https://aur.archlinux.org/packages/pritunl-client-bin) | VPN clients that I use on work                      |
| PHP, composer                                                                                                                                    | PHP programming language and package manager        |
| [Posting](https://github.com/darrenburns/posting)                                                                                                | TUI HTTP client very similar with Postman           |
| [Tiny RDM](https://github.com/tiny-craft/tiny-rdm)                                                                                               | Redis GUI client                                    |

</details>

<details>
  <summary><h3>Utilities</h3></summary>

| Component                                                                        | Description                                         |
|----------------------------------------------------------------------------------|-----------------------------------------------------|
| [duf](https://github.com/muesli/duf)                                             | Disk usage information                              |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch)                          | System information                                  |
| [fx](https://github.com/antonmedv/fx)                                            | Terminal JSON viewer and processor                  |
| [glow](https://github.com/charmbracelet/glow)                                    | Terminal markdown render tool                       |
| [gtt](https://github.com/eeeXun/gtt)                                             | Translate TUI tool                                  |
| [gum](https://github.com/charmbracelet/gum)                                      | Creates TUI components in shell scripts             |
| [hostctl](https://github.com/guumaster/hostctl)                                  | Tool for managing /etc/hosts                        |
| [jq](https://github.com/jqlang/jq)                                               | JSON processing tool                                |
| [pass](https://wiki.archlinux.org/title/Pass)                                    | Password manager                                    |
| [presenterm](https://github.com/mfontanini/presenterm)                           | Terminal presentation tool                          |
| [vdirsyncer](https://github.com/pimutils/vdirsyncer)                             | Tool for synchronizing online calendars             |
| [yandex-music-downloader](https://github.com/llistochek/yandex-music-downloader) | Downloading music from Yandex Music                 |
| [yt-dlp](https://github.com/yt-dlp/yt-dlp)                                       | Downloading video from Youtube and many other sites |

</details>

> Full list of dependencies present in [setup script function](/setup/2-packages.sh)
