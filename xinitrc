(xss-lock slock) &

xrdb -merge $HOME/.Xresources

export GTK_RC_FILES="$HOME/.gtkrc-2.0"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# turn on stickykeys. don't let two keys pressed at the same time disable it.
# don't turn on "latch lock", ie pressing a modifier key twice "locks" it on.
xkbset accessx sticky -twokey -latchlock

# don't expire these settings. (run xkbset q exp for details.)
xkbset exp 1 =accessx =sticky =twokey =latchlock

setxkbmap us altgr-intl -option ctrl:nocaps -option lv3:ralt_switch

xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.3
xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Profile Enabled" 1 0

/usr/lib/systemd/systemd --user &
xbindkeys &
unclutter &
udiskie

exec dbus-launch bubbles
