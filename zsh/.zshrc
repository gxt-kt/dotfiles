# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="ys"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-completions
	zsh-syntax-highlighting
	autojump
	extract
	fzf
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽
################################################
################################################
### Under is my config #########################
################################################
################################################


#🔽🔽🔽
# Autostart X at login
# Ref : https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
#🔼🔼🔼

#🔽🔽🔽
# TMUX config
# if set this , home and end in tmux will be strange, need remap home and end in tmux.
# export TERM=xterm-256color

# default set TMUX in tmux. 
# if [[ -v TMUX ]];
# then
#     # unset TMUX
# fi
#🔼🔼🔼

#🔽🔽🔽
#git
alias g="gitui"
alias gl="git --no-pager log --pretty=format:'%C(auto)%h%d %C(cyan)(%ci) %C(green)%cn %C(reset)%s'  --all --graph --abbrev-commit -5"
alias gll="git --no-pager log --pretty=format:'%C(auto)%h%d %C(cyan)(%ci) %C(green)%cn %C(reset)%s'  --all --graph --abbrev-commit -10"
alias glll="git --no-pager log --pretty=format:'%C(auto)%h%d %C(cyan)(%ci) %C(green)%cn %C(reset)%s'  --all --graph --abbrev-commit -20"
alias gllll="git --no-pager log --pretty=format:'%C(auto)%h%d %C(cyan)(%ci) %C(green)%cn %C(reset)%s'  --all --graph --abbrev-commit"
alias gam='git add . && echo "exec git add all" && git commit -m '
#🔼🔼🔼

#🔽🔽🔽
# proxychains / proxyhains4
hash proxychains4 2>/dev/null && { alias pro='proxychains4'; }
hash proxychains 2>/dev/null && { alias pro='proxychains'; }
#🔼🔼🔼

#🔽🔽🔽
# set proxy
# reference https://wiki.archlinux.org/title/Proxy_server
local proxy="127.0.0.1:7890"
function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi
        local proxy=$1
        export http_proxy="$proxy" \
               https_proxy=$proxy \
        echo "Proxy environment variable set."
        return 0
    fi

    if [ -z ${no_proxy+x} ] ;
    then
    	echo -n "Input server: "; read server
    	echo -n "Input port: "; read port
    	#echo -n "Input server:port like 192.168.123.123 : ";  read server_port
    	#server=$(echo ${server_port} | grep -Po '((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})(\.((2(5[0-5]|[0-4]\d))|[0-1]?\d{1,2})){3}')
    	#port=$(echo ${server_port} | grep -Po '(?<=:)[\d]{1,5}')
    	local proxy=$server:$port
    fi 

    echo -e "Proxy environment variable seted."
    echo "proxy=$proxy"
    export http_proxy="$proxy" \
           https_proxy=$proxy \
           HTTP_PROXY=$proxy \
           HTTPS_PROXY=$proxy 
}
function proxy_off(){
    unset http_proxy https_proxy ftp_proxy rsync_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY
    echo -e "Proxy environment variable removed."
}
function proxy_status(){
    if [ -z ${http_proxy+x} ] && [ -z ${https_proxy+x} ] ;
    then
    	echo -e "No Proxy environment."
    else
    	echo -e "Have Proxy environment."
    fi 
}
#🔼🔼🔼

#🔽🔽🔽
# alias
alias r="ranger"
alias cat="ccat"
# alias tr="trash" # need install trash-cli. And files move to ~/.local/share/Trash/
# 依次检测lvim/nvim是否存在，存在替换成对应的
alias v='bash -c '\''my_vim=""; if command -v lvim >/dev/null 2>&1; then my_vim="lvim"; else if command -v nvim >/dev/null 2>&1; then my_vim="nvim"; else my_vim="vim"; fi; fi; if [ $# -gt 0 ]; then $my_vim "$@"; else $my_vim .; fi'\'' bash'
alias vim='bash -c '\''my_vim=""; if command -v lvim >/dev/null 2>&1; then my_vim="lvim"; else if command -v nvim >/dev/null 2>&1; then my_vim="nvim"; else my_vim="vim"; fi; fi; if [ $# -gt 0 ]; then $my_vim "$@"; else $my_vim .; fi'\'' bash'
alias cf="cd \$(fd --type d --hidden | fzf)"
alias cfh="cd ~ && cd \$(fd --type d --hidden | fzf)" # search from home
#🔼🔼🔼

#🔽🔽🔽
# lunarvim
export PATH="$HOME/.local/bin":$PATH
export EDITOR=$(bash -c 'if command -v lvim >/dev/null 2>&1; then echo "lvim"; elif command -v nvim >/dev/null 2>&1; then echo "nvim"; else echo "vim"; fi')
# export EDITOR='lvim'
#🔼🔼🔼

#🔽🔽🔽
# fzf
local fzf_ignore=".wine,.git,.idea,.vscode,node_modules,build"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude={${fzf_ignore}} "
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --preview 'echo {} | ~/.config/fzf/fzf_preview.py' --preview-window=down --border "
_fzf_compgen_path() {
  fd --hidden --follow --exclude={${fzf_ignore}}
}
_fzf_compgen_dir() {
  fd --type d --hidden --exclude={${fzf_ignore}}
}
#🔼🔼🔼

#🔽🔽🔽
# docker display
xhost +&>/dev/null
#🔼🔼🔼

#🔽🔽🔽
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gxt_kt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gxt_kt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gxt_kt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gxt_kt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#🔼🔼🔼

#🔽🔽🔽
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#🔼🔼🔼

#🔽🔽🔽
# cmake alias
alias cmr='bash ~/.scripts/cmake/compile.sh cmr'
alias mr='bash ~/.scripts/cmake/compile.sh mr'
#🔼🔼🔼

