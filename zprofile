[[ ! -f /tmp/wm.lock && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && touch /tmp/wm.lock && exec startx
PATH="/usr/local/heroku/bin:$PATH"
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
GEM_HOME=$(ruby -e 'print Gem.user_dir')

# source /usr/share/chruby/chruby.sh
# source /usr/share/chruby/auto.sh
# chruby ruby-2.1.4
