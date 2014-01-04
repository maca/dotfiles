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

  # https://wiki.archlinux.org/index.php/Systemd/User
  sed -i s/system-auth/system-login/g /etc/pam.d/systemd-user

  # disable bitmap fonts
  ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
}

# run as root
install_basics () {
  pacman -Syu
  pacman -S arandr awesome chromium cmus deadbeef dialog elinks gawk\
    git gmrun gvim keychain luakit openssh pavucontrol pulseaudio\
    ranger rsync ruby rxvt-unicode smplayer spacefm supercollider\
    terminus-font tk tmux udiskie unclutter urxvt-perls vlc wpa_supplicant\
    wpa_supplicant_gui xcompmgr xf86-video-intel xorg-server xorg-utils\
    xorg-xinit xorg-xrdb zsh ctags acpi conky postgresql sqlite zip unzip\
    dnsmasq wpa_actiond sshfs weechat python2 wget ntp apvlv firefox\
    gpicview ack avahi nss-mdns ttf-freefont imagemagick base-devel dtach\
    polipo quota-tools tor btrfs-progs
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

  sudo systemctl enable netctl-auto@wlp3s0.service
}

# run as user
setup_remote_tunnels(){
  # /usr/lib/systemd/systemd --user &
  systemctl --user enable ssh-tunnel@maca-kujenga.co-9000-22.service
  systemctl --user enable ssh-tunnel@maca-kujenga.co-3000-3000.service
  systemctl --user enable ssh-tunnel@maca-kujenga.co-8080-80.service
}

# run as user
setup_ssh_keys(){
  echo "SSH Key setup"
  ssh-keygen -t rsa -C "$(whoami)@$(cat /etc/hostname)"
}

# run as root
# setup_aur_installs(){
#   cd /tmp
#   bash <(curl aur.sh) -si centerim5-git
#   bash <(curl aur.sh) -si urxvt-perls
#   bash <(curl aur.sh) -si xkbset
#   bash <(curl aur.sh) -si powerdown-git
#   bash <(curl aur.sh) -si pasystray-git
#   bash <(curl aur.sh) -si pavumeter
#   bash <(curl aur.sh) -si pulseaudio-ctl
#   bash <(curl aur.sh) -si create_ap
#   cd -
# }

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
  ln -fs $HOME/dotfiles/bin ~/bin

  mkdir -p ~/.config/fontconfig/
  ln -fs $HOME/dotfiles/awesome ~/.config/awesome
  ln -fs $HOME/dotfiles/gtk-3.0 ~/.config/gtk-3.0
  ln -sf $HOME/dotfiles/gtkrc-2.0 ~/.gtkrc-2.0
  ln -fs $HOME/dotfiles/luakit ~/.config/luakit
  ln -fs $HOME/dotfiles/fonts.conf ~/.config/fontconfig/fonts.conf
  ln -fs $HOME/dotfiles/systemd ~/.config/systemd
}

# run as user
setup_development_environment(){
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv install 2.0.0-p247
  rbenv install 1.9.3-p448
  rbenv global 2.0.0-p247
  gem install bundler
  gem install passenger
  gem install yard
  rbenv rehash
  sudo passenger-install-nginx-module
  sudo ln -fs $HOME/dotfiles/nginx.conf /opt/nginx/conf/nginx.conf
  curl https://toolbelt.heroku.com/install.sh | sh

  sudo sh -c "cat > /etc/systemd/system/nginx.service" <<EOF
[Unit]
Description=A high performance web server and a reverse proxy server
After=syslog.target network.target

[Service]
Type=forking
PIDFile=/run/nginx.pid
ExecStartPre=/opt/nginx/sbin/nginx -t -q -g 'pid /run/nginx.pid; daemon on; master_process on;'
ExecStart=/opt/nginx/sbin/nginx -g 'pid /run/nginx.pid; daemon on; master_process on;'
ExecReload=/opt/nginx/sbin/nginx -g 'pid /run/nginx.pid; daemon on; master_process on;' -s reload
ExecStop=/opt/nginx/sbin/nginx -g 'pid /run/nginx.pid;' -s quit

[Install]
WantedBy=multi-user.target
EOF

  sudo systemctl enable nginx

  git clone https://github.com/creationix/nvm.git ~/.nvm
  source ~/.nvm/nvm.sh
  nvm install 0.10
  nvm alias default 0.10
}


# run as user
setup_documentation(){
  mkdir -p ~/Documentation

  mkdir -p ~/Documentation/jquery
  cd ~/Documentation/jquery
  curl -O http://jqapi.com/jqapi.zip
  unzip jqapi.zip
  rm jqapi.com

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
setup_polipo() {
  groupadd -r polipo
  useradd -d /var/cache/polipo -g polipo -r -s /bin/false polipo
  touch /var/log/polipo.log

  btrfs subvolume create /var/cache/polipo
  btrfs quota enable /var/cache/polipo
  btrfs subvolume list /var/cache/polipo | cut -d' ' -f2 | xargs -I{} -n1 btrfs qgroup create 0/{} /var/cache/polipo
  btrfs quota rescan /var/cache/polipo
  btrfs qgroup limit 10g /var/cache/polipo

  chown -R polipo:polipo /var/log/polipo.log /var/cache/polipo

  cat <<EOT > /etc/systemd/system/polipo.service
.include /usr/lib/systemd/system/polipo.service
[Service]
User=polipo
EOT

  cat <<EOT > /etc/polipo/config
dnsNameServer = 127.0.0.1
socksParentProxy = localhost:9050
socksProxyType = socks5
EOT

  systemctl enable tor
  systemctl enable polipo
}

