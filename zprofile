if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
   sleep 2 && startx
fi


if test -f /usr/share/chruby/chruby.sh; then
    source /usr/share/chruby/chruby.sh
    source /usr/share/chruby/auto.sh
fi

BUNDLE_PATH=$(ruby -e 'print Gem.user_dir')
GEM_HOME=$(ruby -e 'print Gem.user_dir')
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/usr/lib/ruby/gems/3.0.0/bin:$PATH"
BUNDLE_PATH=$(ruby -e 'print Gem.user_dir')

export ERL_AFLAGS="-kernel shell_history enabled"
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"


if command -v yarn &> /dev/null; then
   PATH="$(yarn global bin):$PATH"
fi