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

plugins=(git gem chruby thor heroku vi-mode extract history-substring-search vagrant)

source $ZSH/oh-my-zsh.sh
unset GREP_OPTIONS

# paths
export GOPATH=~/.go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:.ghcup/bin" # haskell ghcup

export BUILDDIR=/scratch

# no need for cd command
setopt autocd

# no share history between sessions
setopt no_share_history

# vi keybindings
bindkey -v

# only past commands beginning with the current input will be shown
# bindkey -M viins "^[[A" vi-cmd-mode-and-history-beginning-search-forward
# bindkey -M viins "^[[B" vi-cmd-mode-and-history-beginning-search-backward
# bindkey -M vicmd "^[[A" history-beginning-search-backward
# bindkey -M vicmd "^[[B" history-beginning-search-forward


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

function prompt_color() {
  echo "%{$reset_color%}%{$fg[yellow]%}"
}

PROMPT='`prompt_color`[%{$fg_bold[red]%}%m`prompt_color`][%{$fg[green]%}%c`prompt_color`] `git_prompt_info``prompt_color`- %{$reset_color%}'
RPROMPT='%{$reset_color%} %{$fg[cyan]%}%*%{$reset_color%}'


export EDITOR=vim
export BROWSER=chromium

alias comp="tar cvfz"
alias space="sudo du -sh *"
alias view="gpicview"
alias x=extract
alias mosh="mosh --predict=experimental"
alias pc="pass -c"
alias vlc="vlc --file-caching=10000"
alias pacman="sudo pacman"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias mount="sudo mount"
alias umount="sudo umount"
alias passcopy="pass show -c1"
alias mpv="mpv --sub-scale=0.6"


sticky_keys() {
   xkbset accessx sticky -twokey -latchlock
   xkbset exp 1 '=accessx' '=sticky' '=twokey' '=latchlock'
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
