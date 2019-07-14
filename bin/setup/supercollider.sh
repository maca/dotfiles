
pacman -S supercollider sc3-plugins
pacman -S realtime-privileges pulseaudio-jack qjackctl
sudo usermod -a -G realtime $(whoami)
