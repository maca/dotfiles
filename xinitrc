(xss-lock slock) &

xrdb -merge $HOME/.Xresources

/home/maca/bin/sticky_keys
xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.8

/usr/lib/systemd/systemd --user &
xbindkeys &
udiskie

exec dbus-launch bubbles
