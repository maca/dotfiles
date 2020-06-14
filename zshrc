export TERM=screen-256color

# ssh-agent socket path
export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket


source $HOME/bin/gtm.sh
unset GREP_OPTIONS


# paths
export GOPATH=~/.go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"


export BUILDDIR=/scratch

# no need for cd command
setopt autocd

# no share history between sessions
setopt no_share_history

# vi keybindings
bindkey -v


autoload -Uz compinit && compinit


###############
#### GIT PROMPT
setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "\033[38;5;15m±" )
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "\033[38;5;15m$GIT_LOCATION%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"

}

# Use ❯ as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1='$(ssh_info)%{$fg[magenta]%}%~%u $(git_info)%(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.❯)%{$reset_color%} '
#### GIT PROMPT
###############



# # Color shortcuts
# RED=$fg[red]
# YELLOW=$fg[yellow]
# GREEN=$fg[green]
# WHITE=$fg[white]
# BLUE=$fg[blue]
# RED_BOLD=$fg_bold[red]
# YELLOW_BOLD=$fg_bold[yellow]
# GREEN_BOLD=$fg_bold[green]
# WHITE_BOLD=$fg_bold[white]
# BLUE_BOLD=$fg_bold[blue]
# RESET_COLOR=$reset_color

# # Format for git_prompt_info()
# ZSH_THEME_GIT_PROMPT_PREFIX=""
# ZSH_THEME_GIT_PROMPT_SUFFIX=""

# # Format for parse_git_dirty()
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$RED%}(*) "
# ZSH_THEME_GIT_PROMPT_CLEAN=" "


# # Format for git_prompt_ahead()
# ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!) "

# # Format for git_prompt_long_sha() and git_prompt_short_sha()
# ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$YELLOW%}"
# ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

# function prompt_color() {
#   echo "%{$reset_color%}%{$fg[yellow]%}"
# }

# function gtm_status() {
#   [ -z "$GTM_STATUS" ] || echo "$GTM_STATUS "
# }

# PROMPT='`prompt_color`[%{$fg_bold[red]%}%m`prompt_color`][%{$fg[green]%}%c`prompt_color`] `git_prompt_info``gtm_status``prompt_color`- %{$reset_color%}'
# RPROMPT='%{$reset_color%} %{$fg[cyan]%}%*%{$reset_color%}'


export EDITOR=vim
export BROWSER=chromium


alias comp="tar cvfz"
alias space="sudo du -sh *"
alias view="gpicview"
alias x=extract
alias mosh="mosh --predict=experimental"
alias vlc="vlc --file-caching=10000"
alias pacman="sudo pacman"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias mount="sudo mount"
alias umount="sudo umount"
alias mpv="mpv --sub-scale=0.6"
alias ls='ls --color=auto'


sticky_keys() {
   xkbset accessx sticky -twokey -latchlock
   xkbset exp 1 '=accessx' '=sticky' '=twokey' '=latchlock'
   setxkbmap us altgr-intl -option ctrl:nocaps -option lv3:ralt_switch
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
