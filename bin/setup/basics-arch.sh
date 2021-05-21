#!/usr/bin/sh
#
# Usage
# bash <(curl -s https://raw.githubusercontent.com/maca/dotfiles/master/bin/setup/basics-arch.sh)


pacman -S git vim zsh pass pass-otp the_silver_searcher fd binutils \
  patch make automake pkgconf fakeroot openssh ruby tmux \
  rsync keychain linux-headers base-devel patch unzip ntp fzf emacs qrencode


ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8     > /etc/locale.conf
echo KEYMAP=us            > /etc/vconsole.conf
echo FONT=Lat2-Terminus16 >> /etc/vconsole.conf
echo "blacklist pcspkr"   > /etc/modprobe.d/pcspkr.conf


systemctl start ntpd
systemctl enable ntpd


export EDITOR=vim

mkinitcpio -p linux

read -p "¿como se llama esta máquina? " hostname

echo $hostname > /etc/hostname

echo "tmpfs   /tmp         tmpfs   nodev,nosuid                  0  0" >> /etc/fstab
echo "tmpfs   /scratch     tmpfs   nodev,nosuid                  0  0" >> /etc/fstab


mkdir /scratch
mount -a

sudo chmod 777 /scratch

read -p "¿como te llamas? " user
useradd -m -g users -G wheel -s /bin/zsh $user
passwd $user
visudo


echo "SSH Key setup"
su - $user -c "ssh-keygen -t ed25519 -C '$user@$(cat /etc/hostname)'"


cat "Public ssh key:"
qrencode -t ansiutf8 < /home/$user/.ssh/id_rsa.pub
