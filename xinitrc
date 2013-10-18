xrdb -merge $HOME/.Xresources


export GTK_RC_FILES="$HOME/.gtkrc-2.0"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"


# turn on stickykeys. don't let two keys pressed at the same time disable it.
# don't turn on "latch lock", ie pressing a modifier key twice "locks" it on.
xkbset accessx sticky -twokey -latchlock

# don't expire these settings. (run xkbset q exp for details.)
xkbset exp 1 =accessx =sticky =twokey =latchlock

# remap caps lock to control, compose accents with menu and left alt as alt_gr
setxkbmap us altgr-intl -option ctrl:nocaps -option lv3:ralt_switch


# To enable horizontal and vertical scrolling with Thinkpad TrackPoint
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5


/usr/lib/systemd/systemd --user &
/usr/bin/start-pulseaudio-x11 &
xcompmgr &
"$HOME/bin/displays" &
simpleswitcher &
unclutter &
udiskie &
conky -d -c "$HOME/dotfiles/conkyrc/conkyrc"


exec dbus-launch awesome
