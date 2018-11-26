#!/usr/bin/sh

# run as root
basic_setup(){
  ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
  locale-gen

  echo LANG=en_US.UTF-8     > /etc/locale.conf
  echo KEYMAP=us            > /etc/vconsole.conf
  echo FONT=Lat2-Terminus16 >> /etc/vconsole.conf
  echo "blacklist pcspkr"   > /etc/modprobe.d/pcspkr.conf

  pacman -S sudo zsh f2fs-tools

  mkinitcpio -p linux

  read -p "¿como se llama esta máquina? " hostname

  echo $hostname > /etc/hostname

  echo "tmpfs   /tmp         tmpfs   nodev,nosuid                  0  0" >> /etc/fstab
  echo "tmpfs   /scratch     tmpfs   nodev,nosuid                  0  0" >> /etc/fstab

  mkdir /scratch
  mount -a


  read -p "¿como te llamas? " user
  useradd -m -g users -G wheel -s /bin/zsh $user
  passwd maca

  visudo
}

# run as user
setup_dotfiles(){
  cd /tmp

  mkdir -p ~/.config

  ln -fs $HOME/dotfiles/systemd ~/.config/systemd
  ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf

  ln -fs /tmp ~/Downloads
  ln -fs $HOME/dotfiles/zshrc ~/.zshrc
  ln -fs $HOME/dotfiles/zprofile ~/.zprofile
  ln -fs $HOME/dotfiles/vimrc ~/.vimrc
  ln -fs $HOME/dotfiles/vim ~/.vim
  ln -fs $HOME/dotfiles/conky ~/.conky
  ln -fs $HOME/dotfiles/gitconfig ~/.gitconfig
  ln -fs $HOME/dotfiles/tmux.conf ~/.tmux.conf
  ln -fs $HOME/dotfiles/xinitrc ~/.xinitrc
  ln -fs $HOME/dotfiles/Xresources ~/.Xresources
  ln -fs $HOME/dotfiles/themes ~/.themes
  ln -fs $HOME/dotfiles/ctags.d ~/.ctags.d
  ln -fs $HOME/dotfiles/gitignore ~/.gitignore
  ln -fs $HOME/dotfiles/bin ~/bin/
  ln -fs $HOME/dotfiles/dynamic-colors ~/.dynamic-colors

  pacman -S pass pass-otp fzf the_silver_searcher binutils \
    patch make automake pkgconf fakeroot openssh ruby tmux \
    rsync keychain xbindkeys linux-headers xf86-input-libinput \
    xorg-xinput

  aur -si chruby xkbset oh-my-zsh-git par ruby-install-git \
    vim-plug universal-ctags-git heroku-client sedutil

  cd -

  mkdir -p ~/.config/fontconfig/
  ln -fs $HOME/dotfiles/bubbles.cfg ~/.config/bubbles.cfg
  ln -fs $HOME/dotfiles/xbindkeysrc ~/.xbindkeysrc

  mkdir -p .password-store/.git/hooks
  ln -fs $HOME/dotfiles/password-store/hooks ~/.password-store/.git/hooks/

  vim +PlugInstall +qall

  echo "SSH Key setup"
  ssh-keygen -t rsa -C "$(whoami)@$(cat /etc/hostname)"
}

# run as user
install_wm(){
  pacman -Syu
  pacman -S\
    gvim rxvt-unicode xorg-server xorg-xinit chromium \
    pulseaudio pulseaudio-alsa urxvt-perls ttf-liberation \
    ttf-dejavu terminus-font gmrun xcompmgr pavucontrol \
    xautolock slock redshift acpi

  cd /tmp

  aur -si urxvt-font-size-git pulseaudio-ctl bubbles-git \
    browserpass xrandr-invert-colors gpicview

  cd -

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

# run as root
setup_trackpoint() {
  cat <<EOT > /etc/X11/xorg.conf.d/20-thinkpad.conf
Section "InputClass"
	Identifier	"Trackpoint Wheel Emulation"
	MatchProduct	"TPPS/2 IBM TrackPoint|DualPoint Stick|Synaptics Inc. Composite TouchPad / TrackPoint|ThinkPad USB Keyboard with TrackPoint|USB Trackpoint pointing device|Composite TouchPad / TrackPoint"
	MatchDevicePath	"/dev/input/event*"
	Option		"EmulateWheel"		"true"
	Option		"EmulateWheelButton"	"2"
	Option		"Emulate3Buttons"	"false"
	Option		"XAxisMapping"		"6 7"
	Option		"YAxisMapping"		"4 5"
EndSection
EOT
}

# run as root
setup_mouse() {
  cat <<EOT > /etc/X11/xorg.conf.d/10-mouse.conf
Section "InputClass"
    Identifier "whatever"
    MatchIsPointer "on"
    Option "Emulate3Buttons" "on"
EndSection
EOT
}

# run as root
setup_keyboard() {
  cat > /etc/X11/xorg.conf.d/01-keyboard_layout.conf <<EOF
Section "InputClass"
        Identifier "keyboard-layout"
        MatchIsKeyboard "yes"
        Option "XkbLayout" "us"
        Option "XkbVariant" "altgr-intl"
        Option "XkbOptions" "ctrl:nocaps"
        Option "XkbOptions" "lv3:ralt_switch"
        Driver "evdev"
EndSection
EOF
}

# run as root
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
