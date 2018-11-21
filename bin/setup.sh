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
  mkinitcpio -p linux

  read -p "¿como se llama esta máquina? " hostname

  echo $hostname > /etc/hostname

  echo "tmpfs   /tmp         tmpfs   nodev,nosuid                  0  0" >> /etc/fstab
  echo "tmpfs   /scratch     tmpfs   nodev,nosuid                  0  0" >> /etc/fstab

  mkdir /scratch
  mount -a
}

# run as user
setup_dotfiles(){
  cd /tmp

  ln -fs $HOME/dotfiles/luakit ~/.config/luakit
  ln -fs $HOME/dotfiles/systemd ~/.config/systemd
  ln -fs $HOME/dotfiles/redshift.conf ~/.config/redshift.conf

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
  ln -fs $HOME/dotfiles/ctags.d ~/.ctags.d
  ln -fs $HOME/dotfiles/gitignore ~/.gitignore
  ln -fs $HOME/dotfiles/bin ~/bin
  ln -fs $HOME/dotfiles/dynamic-colors ~/.dynamic-colors

  pacman -S pass pass-otp fzf the_silver_searcher binutils patch make
  aur -si chruby xkbset oh-my-zsh-git par ruby-install-git vim-plug

  cd -

  mkdir -p ~/.config/fontconfig/
  ln -fs $HOME/dotfiles/bubbles.cfg ~/.config/bubbles.cfg
  ln -fs $HOME/dotfiles/xbindkeysrc ~/.xbindkeysrc

  mkdir -p .password-store/.git/hooks
  ln -fs $HOME/dotfiles/password-store/hooks ~/.password-store/.git/hooks/

  vim +PlugInstall +qall
}

# run as user
setup_tools(){
  aur -si \
    python-sphinxcontrib-newsfeed python-vobject python-wsgi-intercept \
    radicale python-pytest-xprocess python-pytest-subtesthack \
    python-atomicwrites python-click-threading python-click-log vdirsyncer \
    python-tzlocal python-icalendar khal-git \
    python-ansi python-tabulate todoman \

  mkdir -p $HOME/.config/khal
  ln -fs $HOME/dotfiles/khal_config ~/.config/khal/config

  mkdir -p $HOME/.config/vdirsyncer
  ln -fs $HOME/dotfiles/vdirsyncer_config ~/.config/vdirsyncer/config

  mkdir -p $HOME/.config/todoman/
  ln -fs $HOME/dotfiles/todoman/todoman.conf ~/.config/todoman/todoman.conf

  systemctl --user enable vdirsyncer.timer
  systemctl --user start vdirsyncer.timer

  vdirsyncer discover cal
  vdirsyncer sync
}

# run as user
install_basics () {
  pacman -Syu
  pacman -S openssh ruby tmux rsync
}

# run as user
install_wm(){
  pacman -Syu
  pacman -S\
    gvim rxvt-unicode xorg-server xorg-xinit chromium pulseaudio \
    pulseaudio-alsa urxvt-perls terminus-font gmrun xcompmgr \
    pavucontrol xautolock slock

  cd /tmp
  aur -si urxvt-font-size-git pulseaudio-ctl xtrlock \
    bubbles-git redshift-minimal-git
  cd -
}

# run as user
install_dev_env(){
  pacman -Syu
  pacman -S nodejs phantomjs imagemagick postgresql sqlite gpicview
  aur -si universa-ctags-git

  cd /tmp
  aur -si heroku-client
  cd -
}

# run as root
setup_fonts() {
  cat <<EOT > /etc/fonts/conf.avail/33-TerminusPCFFont.conf
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
   <alias>
       <family>Terminus</family>
       <prefer><family>xos4 Terminus</family></prefer>
       <default><family>fixed</family></default>
   </alias>
</fontconfig>
EOT

ln -s /etc/fonts/conf.avail/33-TerminusPCFFont.conf /etc/fonts/conf.d
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

# run as user
setup_automount(){
  pacman -S udevil
  sudo systemctl enable devmon@$(whoami).service
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

setup_vagga(){
  cat <<EOT >> /etc/pacman.conf

[linux-user-ns]
SigLevel = Never
Server = http://files.zerogw.com/arch-kernel/\$arch
EOT

}

setup_webdav_mount(){
  pacman -S davfs2
  sudo usermod -a -G network $(whoami)

  read "url?Url: "
  read "user?User: "
  read -s "password?Password: "
  echo
  read "mount?Mount dir: "

  read "reply?Is the url ($url) correct? "
  if [[ ! $reply =~ ^[Yy]$ ]]
  then
    return 1
  fi

  # Create mount point
  mkdir -p $mount

  # Davfs user secrets
  mkdir -p ~/.davfs2/
  echo "$url $user $password" >> ~/.davfs2/secrets
  chmod 0600 ~/.davfs2/secrets

  # Add mount to fstab
  cat <<EOT | sudo tee -a /etc/fstab
$url $mount davfs user,noauto,uid=$user,file_mode=600,dir_mode=700 0 1
EOT
}

# Run as root
setup_open_vpn() {
  pacman -Sy openvpn ufw bind-tools

  read -p "¿Ya copiaste la configuración para Romania? " response
  aur -si vpnfailsafe-git

  cat <<EOT | tee -a /etc/openvpn/MullVad_ro.conf
script-security 2
up /etc/openvpn/vpnfailsafe.sh
down /etc/openvpn/vpnfailsafe.sh
EOT

  sudo systemctl start openvpn@Mullvad_ro
  sudo systemctl enable openvpn@MullVad_ro
  /home/maca/bin/ufw-kill-switch-setup
}
