[[ ! -f /tmp/wm.lock && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && touch /tmp/wm.lock && exec startx
PATH="/usr/local/heroku/bin:$PATH"
