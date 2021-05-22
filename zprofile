[[ ! -f /tmp/wm.lock && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && touch /tmp/wm.lock && exec startx
{ sleep 3 && if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then startx; fi & disown; } 2>/dev/null

source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh

BUNDLE_DEFAULT_INSTALL_USES_PATH=$(ruby -e 'print Gem.user_dir')
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/usr/lib/ruby/gems/3.0.0/bin:$PATH"
PATH="$(yarn global bin):$PATH"