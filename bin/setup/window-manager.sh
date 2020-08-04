#!/usr/bin/sh

sudo pacman -Syu
sudo pacman -S\
  rxvt-unicode xorg-server xorg-xinit chromium \
  pulseaudio pulseaudio-alsa urxvt-perls ttf-liberation \
  ttf-dejavu terminus-font noto-fonts-emoji noto-fonts-cjk \
  gmrun xcompmgr pavucontrol xautolock slock redshift acpi \
  acpilight xf86-input-libinput xorg-xinput gpicview \
  libpng poppler-glib imagemagick unclutter browserpass \
  browserpass-chromium

cd /tmp

sudo pacman-key --recv-keys 011FDC52DA839335

aur -si urxvt-font-size-git pulseaudio-ctl bubbles-git \
  xrandr-invert-colors xkbset xbindkeys

cd -
mkdir -p ~/.config/fontconfig/

ln -fs $HOME/dotfiles/bubbles.conf ~/.config/bubbles.conf
ln -fs $HOME/dotfiles/xbindkeysrc ~/.xbindkeysrc


# Autologin
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo sh -c "cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $(whoami) --noclear %I 38400 linux
Type=simple
EOF

# Automount
sudo pacman -S udevil
sudo systemctl enable devmon@$(whoami).service

# Fonts
sudo sh -c "cat > /etc/fonts/conf.avail/33-TerminusPCFFont.conf" <<EOF
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
 <alias>
     <family>Terminus</family>
     <prefer><family>xos4 Terminus</family></prefer>
     <default><family>fixed</family></default>
 </alias>
</fontconfig>
EOF

sudo ln -s /etc/fonts/conf.avail/33-TerminusPCFFont.conf /etc/fonts/conf.d


sudo sh -c "cat > /etc/udev/rules.d/backlight.rules" <<EOF
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
EOF
