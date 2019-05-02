#!/usr/bin/sh

aur -si tp-battery-mode
sudo systemctl start tp-battery-mode
sudo systemctl enable tp-battery-mode

sudo pacman -Sy xf86-video-intel

sudo sh -c "cat > /etc/X11/xorg.conf.d/20-intel.conf" <<EOF
Section "Device"
  Identifier  "Intel Graphics"
  Driver      "intel"
  Option      "TearFree" "true"
EndSection
EOF
