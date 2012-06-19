xrdb -merge $HOME/.Xresources

export GTK_RC_FILES="$HOME/.gtkrc-2.0"

# turn on stickykeys. don't let two keys pressed at the same time disable it.
# don't turn on "latch lock", ie pressing a modifier key twice "locks" it on.
xkbset accessx sticky -twokey -latchlock

# don't expire these settings. (run xkbset q exp for details.)
xkbset exp 1 =accessx =sticky =twokey =latchlock

# remap caps lock to control, compose accents with menu and left alt as alt_gr
setxkbmap us altgr-intl -option ctrl:nocaps -option lv3:ralt_switch

# hsetroot -solid "#000066"
# xcompmgr -f &
# $HOME/bin/compmgr start
# unagi &
xcompmgr &
# urxvtd -q -f -o &
sleep 3 && conky &

exec ck-launch-session dbus-launch bash -c "udiskie & awesome"
