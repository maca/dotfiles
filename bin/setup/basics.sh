#!/usr/bin/sh
#
# Usage
# bash <(curl -s https://raw.githubusercontent.com/maca/dotfiles/master/bin/setup/basics.sh)

ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8     > /etc/locale.conf
echo KEYMAP=us            > /etc/vconsole.conf
echo FONT=Lat2-Terminus16 >> /etc/vconsole.conf
echo "blacklist pcspkr"   > /etc/modprobe.d/pcspkr.conf

pacman -S dialog wpa_supplicant git vim \
  sudo zsh pass pass-otp the_silver_searcher binutils \
  patch make automake pkgconf fakeroot openssh ruby tmux \
  rsync keychain linux-headers base-devel patch unzip ntp

mkinitcpio -p linux

read -p "¿como se llama esta máquina? " hostname

echo $hostname > /etc/hostname

echo "tmpfs   /tmp         tmpfs   nodev,nosuid                  0  0" >> /etc/fstab
echo "tmpfs   /scratch     tmpfs   nodev,nosuid                  0  0" >> /etc/fstab

mkdir /scratch
mount -a

read -p "¿como te llamas? " user
useradd -m -g users -G wheel -s /bin/zsh $user
passwd $user

echo "SSH Key setup"
su - $user -c "ssh-keygen -t rsa -C '$user@$(cat /etc/hostname)'"

systemctl start ntpd
systemctl enable ntpd

visudo

cat "Public ssh key:"
cat /home/$user/.ssh/id_rsa.pub
