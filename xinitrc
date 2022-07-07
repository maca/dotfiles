(xss-lock slock) &


xrdb -merge /home/maca/dotfiles/Xresources

if [ -f /home/maca/.Xresources ]; then
    xrdb -merge /home/maca/.Xresources
fi

/home/maca/bin/sticky_keys

xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.05

/usr/lib/systemd/systemd --user &
xbindkeys &
/usr/bin/systemctl --user start redshift

(sleep 1 && /usr/bin/systemctl --user restart redshift) &

exec dbus-launch bubbles
