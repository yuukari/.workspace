# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
	docker
	docker-compose
	encode64
	genpass
	git
	helm
	kitty
	kubectl
	kubectx
	pj
	ssh
	sudo
	zsh-autosuggestions
	fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR=fresh
PROJECT_PATHS=(~/Code/work/simple-decision-maker ~/Code/work/service ~/Code/work/application ~/Code/pet-projects)

# Aliases

alias goland="(&>/dev/null /opt/GoLand*/bin/goland.sh . &) && exit"
alias phpstorm="(&>/dev/null /opt/PhpStorm*/bin/phpstorm.sh . &) && exit"
alias dbe="(&>/dev/null /opt/PhpStorm*/bin/phpstorm.sh \"$HOME\Code\work\database\" &) && exit"

alias get-ip="curl -s ipinfo.io | jq -r .ip"

# Functions

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

function ai() {
    PROXYAPI_API_KEY=$(pass show api-keys/ai/proxyapi 2>/dev/null)
    if [[ -z "$PROXYAPI_API_KEY" ]]; then
        echo "Failed to get ProxyAPI API key from password storage"
        return 1
    fi
    CEREBRAS_API_KEY=$(pass show api-keys/ai/cerebras 2>/dev/null)
    if [[ -z "$CEREBRAS_API_KEY" ]]; then
        echo "Failed to get Cerebras API key from password storage"
        return 1
    fi
    
    CONFIG_TEMPLATE="$HOME/.config/aichat/config.template.yaml"
    if [[ ! -f "$CONFIG_TEMPLATE" ]]; then
        echo "Config template file for aichat not exists (path: $CONFIG_TEMPLATE)"
        return 1
    fi
    
    CONFIG_FILE="$(mktemp /tmp/aichat-$$-XXXXXX.yaml)"
    cleanup() {
        [[ -n "$CONFIG_FILE" && -f "$CONFIG_FILE" ]] && rm -f "$CONFIG_FILE"
    }
    trap cleanup EXIT INT TERM

    PROXYAPI_API_KEY_ESCAPED=$(printf '%s\n' "$PROXYAPI_API_KEY" | sed 's/[\\&/]/\\&/g')
    CEREBRAS_API_KEY_ESCAPED=$(printf '%s\n' "$CEREBRAS_API_KEY" | sed 's/[\\&/]/\\&/g')
    
    sed -e "s/\${PROXYAPI_API_KEY}/$PROXYAPI_API_KEY_ESCAPED/g" \
        -e "s/\${CEREBRAS_API_KEY}/$CEREBRAS_API_KEY_ESCAPED/g" \
        "$CONFIG_TEMPLATE" > "$CONFIG_FILE"
    
    export AICHAT_CONFIG_FILE="$CONFIG_FILE"
    command aichat "$@"
    local EXIT_CODE=$?
    cleanup
    return $EXIT_CODE
}

function ymd() {
    YANDEX_MUSIC_TOKEN="$(pass show api-keys/yandex-music-token)"
    if [[ -z "$YANDEX_MUSIC_TOKEN" ]]; then
        echo "Failed to get yandex music token from password storage"
        return 1
    fi
    command yandex-music-downloader --token "$YANDEX_MUSIC_TOKEN" --dir ~/Downloads/ymd --path-pattern '#album-artist - #album/#number - #album-artist - #title' --quality 2 "$@"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

# The next line updates PATH for CLI.
if [ -f '/home/yuukari/yandex-cloud/path.bash.inc' ]; then source '/home/yuukari/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/yuukari/yandex-cloud/completion.zsh.inc' ]; then source '/home/yuukari/yandex-cloud/completion.zsh.inc'; fi
