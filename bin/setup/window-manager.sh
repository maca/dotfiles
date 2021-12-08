#!/usr/bin/sh

sudo pacman -Syu
sudo pacman -S\
  alacritty xorg-server xorg-xinit chromium \
  ttf-liberation ttf-jetbrains-mono \
  ttf-dejavu terminus-font noto-fonts-emoji noto-fonts-cjk \
  gmrun xcompmgr xautolock slock redshift acpi \
  acpilight xf86-input-libinput xorg-xinput gpicview \
  libpng poppler-glib imagemagick unclutter browserpass \
  browserpass-chromium nautilus dmenu dhcpcd


cd /tmp

sudo pacman-key --recv-keys 011FDC52DA839335


cd -
mkdir -p ~/.config/fontconfig/

ln -fs $HOME/dotfiles/bubbles.conf ~/.config/bubbles.conf
ln -fs $HOME/dotfiles/termite ~/.config/termite
ln -fs $HOME/dotfiles/xbindkeysrc ~/.xbindkeysrc
ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf
ln -fs $HOME/dotfiles/xinitrc ~/.xinitrc
ln -fs $HOME/dotfiles/Xresources ~/.Xresources

aur -si xkbset xbindkeys

# pacman -S pulseaudio pulseaudio-alsa
# aur -si pulseaudio-ctl bubbles-git
# mkdir -p ~/.config/pulseaudio-ctl/
# ln -fs $HOME/dotfiles/pulseaudio-ctl.config ~/.config/pulseaudio-ctl/config

# Brightness control
sudo usermod -aG video $(whoami)

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

# Dhcp
sudo systemctl status dhcpcd.service


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




# Display link
aur -si evdi-git displaylink

sudo sh -c "cat > /etc/X11/xorg.conf.d/20-displaylink.conf" <<EOF
Section "Device"
  Identifier "DisplayLink"
  Driver "modesetting"
  Option "PageFlip" "false"
EndSection
EOF


sudo sh -c "cat > /etc/X11/xorg.conf.d/20-evdidevice.conf" <<EOF
Section "OutputClass"
  Identifier "DisplayLink"
  MatchDriver "evdi"
  Driver "modesetting"
  Option "AccelMethod" "none"
EndSection
EOF



### Change layout when happy hacking keyboard is connected
sudo sh -c "cat > /etc/udev/rules.d/keyboard.rules" <<EOF
SUBSYSTEM=="input", ATTRS{idVendor}=="0853", ATTRS{idProduct}=="0100", SYMLINK+="keyboard", TAG+="systemd"
EOF

systemctl --user enable --now sticky_keys


### Monitor hot plug
sudo sh -c "cat > /etc/udev/rules.d/monitor.rules" <<EOF
ACTION=="change", SUBSYSTEM=="drm", ENV{SYSTEMD_USER_WANTS}+="monitor-hotplug@\$env{SEQNUM}.service", TAG+="systemd"
EOF
