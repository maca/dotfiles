#!/usr/bin/sh

# run as user
install_wm(){
  pacman -Syu
  pacman -S\
    gvim rxvt-unicode xorg-server xorg-xinit chromium \
    pulseaudio pulseaudio-alsa urxvt-perls ttf-liberation \
    ttf-dejavu terminus-font gmrun xcompmgr pavucontrol \
    xautolock slock redshift acpi xbindkeys \
    xf86-input-libinput xorg-xinput

  cd /tmp

  sudo pacman-key --recv-keys 011FDC52DA839335

  aur -si urxvt-font-size-git pulseaudio-ctl bubbles-git \
    browserpass xrandr-invert-colors gpicview xkbset

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
  pacman -S udevil
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
}

# run as root
setup_postgresql(){
  pacman -Sy postgresql

  systemd-tmpfiles --create postgresql.conf
  mkdir -p /var/lib/postgres/data
  chown -c -R postgres:postgres /var/lib/postgres
  su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
  systemctl enable postgresql
  systemctl start postgresql
  su - postgres -c "createuser -s -U postgres --interactive"
}

# run as root
setup_network(){
  pacman -Sy
  pacman -S openssl ntp dnsmasq

  systemctl enable sshd
  systemctl enable ntpd.service

  echo "nameserver 127.0.0.1"     >  /etc/resolv.conf.head
  echo address=/.local/127.0.0.1    >> /etc/dnsmasq.conf
  echo address=/.doc/127.0.0.1    >> /etc/dnsmasq.conf

  systemctl enable dnsmasq

  echo "manually enable netct-auto 'sudo systemctl enable netctl-auto@wlp3s0.service'"
}

# run as root
setup_pair() {
  useradd -m -s /opt/bin/attach-t1-readonly guest
  useradd -m -s /opt/bin/attach-t1 pairticipant

  mkdir -p /opt/bin
  chmod 755 /opt/bin

  echo "#!/bin/sh" > /opt/bin/attach-t1-readonly
  echo "tmux -S /tmp/tmux-sessions/t1 attach -t t1 -r" >> /opt/bin/attach-t1-readonly
  chmod 755 /opt/bin/attach-t1-readonly

  echo "#!/bin/sh" > /opt/bin/attach-t1
  echo "tmux -S /tmp/tmux-sessions/t1 attach -t t1" >> /opt/bin/attach-t1
  chmod 755 /opt/bin/attach-t1

  echo /opt/bin/attach-t1 >> /etc/shells
  echo /opt/bin/attach-t1-readonly >> /etc/shells
}

# run as user
setup_power_keys() {
  sudo sh -c "cat > /etc/systemd/logind.conf" <<EOF
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
HandlePowerKey=poweroff
HandleSuspendKey=suspend
HandleHibernateKey=reboot
HandleLidSwitch=ignore
#HandleLidSwitchDocked=ignore
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RemoveIPC=yes
EOF
}


# run as user
setup_remote_tunnels(){
   /usr/lib/systemd/systemd --user &
  systemctl --user enable ssh-public-tunnel@maca-kujenga.co-9000-22.service
  systemctl --user enable ssh-tunnel@maca-kujenga.co-3000-3000.service
  # systemctl --user enable ssh-tunnel@maca-kujenga.co-8080-80.service
}

# run as user
setup_docker() {
  pacman -Sy docker docker-compose
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -a -G docker $(whoami)
}

