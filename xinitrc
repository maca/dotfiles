xrdb -merge $HOME/.Xresources

export GTK_RC_FILES="$HOME/.gtkrc-2.0"
setxkbmap us -option ctrl:nocaps &

exec awesome
