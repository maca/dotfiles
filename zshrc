# if [[ -z "$TMUX" ]]; then
#   tmux att || tmux
# fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export PATH="$HOME/.rbenv/bin:$PATH"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(git gem thor bundler heroku rbenv vi-mode nyan extract)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/Users/vermelho/.rbenv/shims:/Users/vermelho/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbini:/usr/local/sbin:/sbin:/usr/X11/bin:~/bin:/Developer/usr/bin
# export NODE_PATH=/usr/local/lib/node_modules
eval "$(rbenv init -)"

# no need for cd command
setopt autocd

# vi keybindings
bindkey -v

# Use modern completion system
autoload -Uz compinit
compinit

# Custom widgets and keybidngs
# enter insert mode and kill line
function vi-cmd-mode-kill-whole-line() {
  zle .kill-whole-line
  zle .vi-insert
}
zle -N vi-cmd-mode-kill-whole-line

function vi-cmd-mode-and-history-beginning-search-backward() {
  zle .vi-cmd-mode
  zle .history-beginning-search-backward
}
zle -N vi-cmd-mode-and-history-beginning-search-backward

function vi-cmd-mode-and-history-beginning-search-forward() {
  zle .vi-cmd-mode
  zle .history-beginning-search-forward
}
zle -N vi-cmd-mode-and-history-beginning-search-forward

# only past commands beginning with the current input will be shown
bindkey -M viins "^[[A" vi-cmd-mode-and-history-beginning-search-forward
bindkey -M viins "^[[B" vi-cmd-mode-and-history-beginning-search-backward
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[" vi-cmd-mode-kill-whole-line

function my_ip() {
  curl cfaj.freeshell.org/ipaddr.cgi
}

function my_local_ip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
	ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
	ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

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

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}deleted"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}modified"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}added"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}untracked"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!) "

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

function git_prompt_details() {
  refs=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo $(vi_prompt_mode_color)\ \|\ %{$GREEN_BOLD%}$(current_branch)$(git_prompt_status)%{$RESET_COLOR%}
}

function directory_item_count_prompt() {
  echo "$((`ls -Al | wc -l` - 1)) items"
}

function directory_size_propmt() {
  echo `du -hc . | tail -1 | sed s/total//`
}

function vi_prompt_mode_color() {
  echo "%{$fg[yellow]%}`vi_mode_prompt_info`"
}

MODE_INDICATOR="%{$fg_bold[cyan]%}"
PROMPT='`vi_prompt_mode_color``vi_prompt_mode_color`[%{$fg[green]%}%c`vi_prompt_mode_color`] `git_prompt_info``vi_prompt_mode_color`- %{$reset_color%}'
RPROMPT='%{$reset_color%}`directory_item_count_prompt``git_prompt_details` `vi_prompt_mode_color`| %{$fg[cyan]%}%*%{$reset_color%}'

function fuzzy_autocomplete() {
  locate `pwd` | sed 's?'`pwd`'??' | grep -i -E `echo "$@" | sed 's|\(.\)(?:$)|\1.*|g'` | grep -v all
}

zle -C complete menu-complete complete-files
bindkey '^T' complete
complete-files () { 
  compadd -U -f -- $(command locate `pwd` | sed 's?'`pwd`/'??' | grep -i -E `echo "$PREFIX" | sed 's|\(.\)|\1.*|g' | head -30`)
}

zle -C complete-locate menu-complete complete-files-locate
bindkey '^F' complete-locate
complete-files-locate () { 
  compadd -U -f -- $(command locate "$PREFIX" | sed 's?'`pwd`/'??')
}

setopt menu_complete   # autoselect the first completion entry
zstyle ':completion:*:ls:*' file-patterns '*(/):directories'

export EDITOR=`which vim`

function v() {
  vim --servername "TERM" --remote-send "<Esc><C-w>p<C-w><C-v><C-w><C-l> :e $@ <CR>"
}

function h() {
  vim --servername "TERM" --remote-send "<Esc><C-w>p<C-w><C-s><C-w><C-j> :e $@ <CR>"
}

function e() {
  vim --servername "TERM" --remote-silent $@
}

function all-excluding() {
  local pattern="\"^\./(`echo ${(pj:|:)@} | sed 's:\.:\\.:g'`)\""
  eval "find . | grep -v -E $pattern"
}

function rails-replace() {
  rails-source-files | xargs grep "$1" | cut -d ":" -f 1 | while read file; do
    mvim --remote $file; 
  done
  mvim --remote-send "<Esc> :bufdo %s/$1/$2/gIc | update"
}

function rails-source-files() {
  all-excluding tmp log db .git vendor
}

# teamocil autocomplete
compctl -g '~/.teamocil/*(:t:r)' teamocil

# alias
alias sup="/Users/vermelho/.rbenv/versions/1.8.7-p352/bin/sup"
alias etter="sudo ettercap -C -i en1"
alias rs=rspec
alias g=git
alias offline-site="wget -r -k -p"
alias compress="tar cvfz" 
alias space="du -sh *"
alias pacman="sudo pacman"
alias ll="ls -a"

# notes
export n=~/notes

vn() {
	$EDITOR ~/notes/"$*".markdown
}

nls() {
	ls -c ~/notes/ | grep "$*"
}


