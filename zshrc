# Path to your oh-my-zsh configuration.
export TERM=screen-256color

ZSH=/usr/share/oh-my-zsh/

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(git gem thor heroku vi-mode nyan extract history-substring-search vagrant)

source $ZSH/oh-my-zsh.sh
unset GREP_OPTIONS

# paths
export GOPATH=~/.go
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.dynamic-colors/bin:$PATH"

export BUILDDIR=/scratch

# no need for cd command
setopt autocd

# no share history between sessions
setopt no_share_history

# vi keybindings
bindkey -v

# Use modern completion system
# autoload -Uz compinit
# compinit

# Custom widgets and keybidngs
# enter insert mode and kill line
function vi-cmd-mode-kill-whole-line() {
  zle .kill-whole-line
  zle .vi-insert
}
zle -N vi-cmd-mode-kill-whole-line

# only past commands beginning with the current input will be shown
bindkey -M viins "^[[A" vi-cmd-mode-and-history-beginning-search-forward
bindkey -M viins "^[[B" vi-cmd-mode-and-history-beginning-search-backward
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[" vi-cmd-mode-kill-whole-line


# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*) "
ZSH_THEME_GIT_PROMPT_CLEAN=""


# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!) "

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

function vi_prompt_mode_color() {
  echo "%{$fg[yellow]%}`vi_mode_prompt_info`"
}

MODE_INDICATOR="%{$fg_bold[cyan]%}"
PROMPT='`vi_prompt_mode_color``vi_prompt_mode_color`[%{$fg[green]%}%m`vi_prompt_mode_color`][%{$fg[green]%}%c`vi_prompt_mode_color`] `git_prompt_info``vi_prompt_mode_color`- %{$reset_color%}'
RPROMPT='%{$reset_color%} %{$fg[cyan]%}%*%{$reset_color%}'


export EDITOR=vim
export BROWSER=chromium

# alias
alias etter="sudo ettercap -C -i en1"
alias rs=rspec
alias g=git
alias offline-site="wget -r -k -p"
alias comp="tar cvfz"
alias space="sudo du -sh *"
alias pacman="sudo pacman"
alias docker-job="docker run --rm"

alias dcu="docker-compose up"
alias dcr="docker-compose run"

alias ll="ls -la"
alias l.="ls -a"

alias ..='cd ..'

alias view="gpicview"
# if [ -f /usr/bin/gvim ]; then; alias vim="vim --servername TERM"; fi
alias x=extract
alias offline-site="wget -r -k -p"
alias trim-white="find ./ -type f -exec sed -i 's/ *$//' '{}' ';'"

alias mosh="mosh --predict=experimental"

# sudo aliases
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias halt="sudo halt"
alias mount="sudo mount"
alias umount="sudo umount"
alias powerdown="sudo powerdown"
alias powerup="sudo powerup"
alias powernow="sudo powernow"
alias suspend="sudo pm-suspend"
alias hibernate="sudo pm-hibernate"
alias powertop="sudo powertop"
alias off="sudo shutdown -hP now"

alias rlog="tail -f log/development.log | grep -vE \"(^\s*$|asset)\""
alias vlc="vlc --file-caching=10000"
alias aur="bash <(curl aur.sh) -si"

alias v='f -t -e e -b viminfo'

sticky_keys() {
   xkbset accessx sticky -twokey -latchlock
   xkbset exp 1 '=accessx' '=sticky' '=twokey' '=latchlock'
}

# ssh keychain, manage ssh keys
eval $(keychain --eval --agents ssh -Q --quiet id_rsa)



# Launch a playbook.
# Usage: ap some_playbook.yml
alias ap="ansible-playbook --vault-password-file ~/pppddd"
# View a vault file.
# Usage: avv group_vars/all/vault.yml
alias avv="ansible-vault view --vault-password-file ~/pppddd"
# Edit the vault in Sublime (in case you don't use sublime, replace the EDITOR part with your own editor).
# Usage: ave group_vars/all/vault.yml
alias ave="ansible-vault edit --vault-password-file ~/pppddd"

source $HOME/.dynamic-colors/completions/dynamic-colors.zsh
