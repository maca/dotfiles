#!/usr/bin/sh

# run as root
install_basics () {
  pacman -Syu
  pacman -S arandr awesome chromium cmus dialog gawk\
    git gmrun gvim keychain luakit openssh pavucontrol pulseaudio\
    ranger rsync ruby rxvt-unicode smplayer spacefm supercollider\
    terminus-font tk tmux udiskie unclutter urxvt-perls vlc wpa_supplicant\
    wpa_supplicant_gui xcompmgr xf86-video-intel xorg-server xorg-utils\
    xorg-xinit xorg-xrdb zsh ctags acpi conky postgresql sqlite zip unzip\
    dnsmasq wpa_actiond sshfs weechat python2 wget ntp apvlv firefox\
    gpicview ack avahi nss-mdns ttf-freefont imagemagick base-devel dtach\
    tor btrfs-progs redshift\
    pulseaudio-alsa bluez bluez-libs bluez-utils bluez-firmware\
    nodejs phantomjs zenity
}


# run as root
basic_setup(){
  ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
  locale-gen

  echo LANG=en_US.UTF-8     > /etc/locale.conf
  echo KEYMAP=us            > /etc/vconsole.conf
  echo FONT=Lat2-Terminus16 >> /etc/vconsole.conf
  echo "blacklist pcspkr"   > /etc/modprobe.d/pcspkr.conf
  mkinitcpio -p linux

  read -p "¿como se llama esta máquina? " hostname
  echo $hostname > /etc/hostname

  echo "tmpfs   /tmp         tmpfs   nodev,nosuid                  0  0" >> /etc/fstab
  echo "tmpfs   /scratch     tmpfs   nodev,nosuid                  0  0" >> /etc/fstab

  mkdir /scratch

  # https://wiki.archlinux.org/index.php/Systemd/User
  sed -i s/system-auth/system-login/g /etc/pam.d/systemd-user

  # disable bitmap fonts
  ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
}

# run as root
setup_postgresql(){
  systemd-tmpfiles --create postgresql.conf
  mkdir /var/lib/postgres/data
  chown -c -R postgres:postgres /var/lib/postgres
  su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
  systemctl enable postgresql
  systemctl start postgresql
  su - postgres -c "createuser -s -U postgres --interactive"
}

# run as root
setup_network(){
  systemctl enable sshd
  systemctl enable ntpd.service

  echo "nameserver 192.168.100.1" >  /etc/resolv.conf
  echo "nameserver 127.0.0.1"     >> /etc/resolv.conf
  echo "nameserver 127.0.0.1"     >  /etc/resolv.conf.head
  echo address=/.dev/127.0.0.1    >> /etc/dnsmasq.conf
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
    [[ -d /etc/X11/xorg.conf.d ]] && cat > /etc/X11/xorg.conf.d/01-keyboard_layout.conf <<EOF
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
  cat <<EOT > /etc/systemd/logind.conf
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
#HandlePowerKey=poweroff
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
EOT

}

# run as root
setup_fonts() {
  cat <<EOT >> /etc/pacman.conf

[infinality-bundle]
Server = http://bohoomil.com/repo/\$arch

[infinality-bundle-multilib]
Server = http://bohoomil.com/repo/multilib/\$arch

[infinality-bundle-fonts]
Server = http://bohoomil.com/repo/fonts
EOT

  pacman -Syy
  pacman -S ttf-aller ttf-amiri ttf-bitstream-vera ttf-brill\
    ttf-dejavu ttf-freefont ttf-inconsolata ttf-liberation\
    ttf-linux-libertine ttf-monaco ttf-ms-fonts ttf-oxygen-ibx\
    ttf-ubuntu-font-family ttf-vista-fonts cairo-infinality-ultimate\
    fontconfig-infinality-ultimate freetype2-infinality-ultimate
}

# run as root
setup_aur_installs(){
  cd /tmp
  bash <(curl aur.sh) -si urxvt-perls-git chruby fasd heroku-client otf-neris\
    par ruby-install-git silver-searcher-git ttf-aller ttf-amiri\
    ttf-brill ttf-monaco ttf-ms-fonts ttf-vista-fonts urxvt-font-size-git\
    urxvt-perls-git xkbset
  cd -
}


# run as user
setup_auto_login(){
  sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
  sudo sh -c "cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $(whoami) --noclear %I 38400 linux
Type=simple
EOF

}

# run as user
setup_dotfiles(){
  cd ~/dotfiles
  git submodule init
  git submodule update
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

  ln -fs /tmp ~/Downloads
  ln -fs $HOME/dotfiles/zshrc ~/.zshrc
  ln -fs $HOME/dotfiles/zshenv ~/.zshenv
  ln -fs $HOME/dotfiles/zprofile ~/.zprofile
  ln -fs $HOME/dotfiles/vimrc ~/.vimrc
  ln -fs $HOME/dotfiles/vim ~/.vim
  ln -fs $HOME/dotfiles/conky ~/.conky
  ln -fs $HOME/dotfiles/gitconfig ~/.gitconfig
  ln -fs $HOME/dotfiles/tmux.conf ~/.tmux.conf
  ln -fs $HOME/dotfiles/xinitrc ~/.xinitrc
  ln -fs $HOME/dotfiles/Xresources ~/.Xresources
  ln -fs $HOME/dotfiles/themes ~/.themes
  ln -fs $HOME/dotfiles/ctags ~/.ctags
  ln -fs $HOME/dotfiles/gitignore ~/.gitignore
  ln -fs $HOME/dotfiles/bin ~/bin

  mkdir -p ~/.config/fontconfig/
  ln -fs $HOME/dotfiles/awesome ~/.config/awesome
  ln -fs $HOME/dotfiles/gtk-3.0 ~/.config/gtk-3.0
  ln -sf $HOME/dotfiles/gtkrc-2.0 ~/.gtkrc-2.0
  ln -fs $HOME/dotfiles/luakit ~/.config/luakit
  ln -fs $HOME/dotfiles/fonts.conf ~/.config/fontconfig/fonts.conf
  ln -fs $HOME/dotfiles/systemd ~/.config/systemd
  ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf
}

# run as user
setup_remote_tunnels(){
   /usr/lib/systemd/systemd --user &
  systemctl --user enable ssh-public-tunnel@maca-kujenga.co-9000-22.service
  systemctl --user enable ssh-tunnel@maca-kujenga.co-3000-3000.service
  # systemctl --user enable ssh-tunnel@maca-kujenga.co-8080-80.service
}

# run as user
setup_ssh_keys(){
  echo "SSH Key setup"
  ssh-keygen -t rsa -C "$(whoami)@$(cat /etc/hostname)"
}

setup_development_environment(){
  gem install bundler
  gem install passenger
  gem install yard
  sudo systemctl enable nginx
}

# run as user
setup_documentation(){
  mkdir -p ~/Documentation

  mkdir -p ~/Documentation/jquery
  cd ~/Documentation/jquery
  curl -O http://jqapi.com/jqapi.zip
  unzip jqapi.zip
  rm jqapi.zip

  mkdir -p ~/Documentation/yard
  mkdir -p ~/Documentation/yard/public
  cat <<EOT > ~/Documentation/yard/config.ru
require 'rubygems'
require 'yard'

libraries = {}
gems = Gem.source_index.find_name('').each do |spec|
  libraries[spec.name] ||= []
  libraries[spec.name] << YARD::Server::LibraryVersion.new(spec.name, spec.version.to_s, nil, :gem)
end

run YARD::Server::RackAdapter.new libraries
EOT

  cd ~
}

