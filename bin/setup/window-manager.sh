#!/usr/bin/sh

sudo pacman -Syu
sudo pacman -S\
  gvim rxvt-unicode xorg-server xorg-xinit chromium \
  pulseaudio pulseaudio-alsa urxvt-perls ttf-liberation \
  ttf-dejavu terminus-font gmrun xcompmgr pavucontrol \
  xautolock slock redshift acpi acpilight xbindkeys \
  xf86-input-libinput xorg-xinput gpicview \
  libpng poppler-glib imagemagick

cd /tmp

sudo pacman-key --recv-keys 011FDC52DA839335

aur -si urxvt-font-size-git pulseaudio-ctl bubbles-git \
  browserpass xrandr-invert-colors xkbset

cd -
mkdir -p ~/.config/fontconfig/

ln -fs $HOME/dotfiles/bubbles.cfg ~/.config/bubbles.cfg
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

