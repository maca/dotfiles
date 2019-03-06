[[ ! -f /tmp/wm.lock && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && touch /tmp/wm.lock && exec startx

source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
