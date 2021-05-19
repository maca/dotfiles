(xss-lock slock) &

xrdb -merge $HOME/.Xresources

/home/maca/bin/sticky_keys

/usr/lib/systemd/systemd --user &
xbindkeys &
/usr/bin/systemctl --user start redshift &
udiskie

(sleep 1 && /usr/bin/systemctl --user restart redshift) &

exec dbus-launch bubbles
