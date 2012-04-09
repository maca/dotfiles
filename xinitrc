xrdb -merge $HOME/.Xresources

export GTK_RC_FILES="$HOME/.gtkrc-2.0"
setxkbmap us -option ctrl:nocaps &

conky &
wpa_gui -t &
nitrogen --restore &
xcompmgr -c -C &

exec ck-launch-session dbus-launch awesome
# exec awesome
