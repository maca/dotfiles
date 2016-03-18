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
  bash <(curl aur.sh) -si chruby fasd xkbset oh-my-zsh-git par\
    ruby-install-git silver-searcher-git vundle
  cd -
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
  ln -fs $HOME/dotfiles/ctags ~/.ctags
  ln -fs $HOME/dotfiles/gitignore ~/.gitignore
  ln -fs $HOME/dotfiles/bin ~/bin

  mkdir -p ~/.config/fontconfig/
  ln -fs $HOME/dotfiles/awesome ~/.config/awesome
  ln -fs $HOME/dotfiles/gtk-3.0 ~/.config/gtk-3.0
  ln -sf $HOME/dotfiles/gtkrc-2.0 ~/.gtkrc-2.0

  vim +PluginInstall +qall
}

# run as user
install_basics () {
  pacman -Syu
  pacman -S cmus dialog wpa_supplicant wpa_actiond gawk git keychain openssh\
    pulseaudio rsync ruby tk tmux udiskie vim acpi conky zip unzip\
    dnsmasq sshfs weechat python2 wget ntp ack dtach tor btrfs-progs\
    pulseaudio-alsa bluez bluez-libs bluez-utils bluez-firmware alsa-lib\
    libpulse faad2 flac libmad libmp4v2 libvorbis wavpack
}

# run as user
install_wm(){
  pacman -Syu
  pacman -S awesome chromium rxvt-unicode smplayer spacefm terminus-font\
    xf86-video-intel xorg-server xorg-utils redshift zenity apvlv firefox\
    xcompmgr xorg-xinit xorg-xrdb pavucontrol gmrun unclutter urxvt-perls\
    vlc gvim arandr

  cd /tmp
  bash <(curl aur.sh) -si urxvt-font-size-git pulseaudio-ctl xtrlock
  cd -
}

# run as user
install_dev_env(){
  pacman -Syu
  pacman -S ctags nodejs phantomjs imagemagick postgresql sqlite gpicview

  cd /tmp
  bash <(curl aur.sh) -si heroku-client
  cd -
}

# run as user
setup_fonts() {
  sudo sh -c "cat >> /etc/pacman.conf" <<EOF

[infinality-bundle]
Server = http://bohoomil.com/repo/\$arch

[infinality-bundle-multilib]
Server = http://bohoomil.com/repo/multilib/\$arch

[infinality-bundle-fonts]
Server = http://bohoomil.com/repo/fonts
EOF

  sudo pacman-key -r 962DDE58
  sudo pacman-key -lsign-key 962DDE58
  sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

  pacman -Sy
  pacman -S ttf-bitstream-vera\
    ttf-dejavu ttf-freefont ttf-inconsolata ttf-liberation\
    ttf-linux-libertine ttf-oxygen-ibx\
    ttf-ubuntu-font-family cairo-infinality-ultimate\
    fontconfig-infinality-ultimate freetype2-infinality-ultimate

  cd /tmp
  bash <(curl aur.sh) -si otf-neris ttf-brill ttf-monaco ttf-ms-fonts\
  ttf-vista-fonts ttf-aller ttf-amiri otf-neris ttf-monaco\
  ttf-brill ttf-freefont ttf-ms-fonts
  cd -
}

# run as root
setup_postgresql(){
  # pacman -Sy
  # pacman -S postgresql

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
  pacman -Sy
  pacman -S openssl ntp dnsmasq

  systemctl enable sshd
  systemctl enable ntpd.service

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
