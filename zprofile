[[ ! -f /tmp/wm.lock && -z $DISPLAY && $XDG_VTNR -eq 1 ]] && touch /tmp/wm.lock && exec startx

PATH="/usr/local/heroku/bin:$PATH"
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
GEM_HOME=$(ruby -e 'print Gem.user_dir')

source /usr/share/chruby/chruby.sh
source /usr/share/chruby/auto.sh

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
fi
