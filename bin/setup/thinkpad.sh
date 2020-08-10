#!/usr/bin/sh

aur -si tp-battery-mode
sudo pacman -S xss-lock
sudo systemctl start tp-battery-mode
sudo systemctl enable tp-battery-mode

sudo sh -c "cat > /etc/X11/xorg.conf.d/20-intel.conf" <<EOF
Section "Device"
  Identifier "Intel Graphics"
  Driver "modesetting"
EndSection
EOF


# Backlight allowed for members of video group
sudo sh -c "cat > /etc/udev/rules.d/backlight.rules" <<EOF
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
EOF


sudo sh -c "cat > /etc/systemd/logind.conf" <<EOF
[Login]
#NAutoVTs=6
#ReserveVT=6
#KillUserProcesses=no
#KillOnlyUsers=
#KillExcludeUsers=root
#InhibitDelayMaxSec=5
#HandlePowerKey=poweroff
#HandleSuspendKey=suspend
#HandleHibernateKey=hibernate
HandleLidSwitch=lock
#HandleLidSwitchExternalPower=suspend
#HandleLidSwitchDocked=ignore
#PowerKeyIgnoreInhibited=no
#SuspendKeyIgnoreInhibited=no
#HibernateKeyIgnoreInhibited=no
#LidSwitchIgnoreInhibited=yes
#HoldoffTimeoutSec=30s
#IdleAction=ignore
#IdleActionSec=30min
#RuntimeDirectorySize=10%
#RemoveIPC=yes
#InhibitorsMax=8192
#SessionsMax=8192
EOF


### Fix opal sleep issues
aur -si sedutil-sleep-git

read -p "enter OPAL password: " password
HASH=$(sudo sedutil-sleep --printPasswordHash $password /dev/nvme0n1)


sudo sh -c "cat > /etc/systemd/system/sedutil-sleep.service" <<EOF
[Unit]
Description=sedutil-sleep

[Service]
Type=oneshot
ExecStart=-+/usr/bin/sedutil-sleep -n -x --prepareForS3Sleep 0 $HASH /dev/nvme0n1
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable sedutil-sleep.service


# https://wiki.archlinux.org/index.php/laptop#Hibernate_on_low_battery_level
sudo sh -c "cat > /etc/udev/rules.d/lowbat.rules" <<EOF
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/usr/bin/systemctl suspend"
EOF



# Rfkill unblock on resume
sudo sh -c "cat > /etc/systemd/system/resume.service" <<EOF
[Unit]
Description=Resume actions
After=suspend.target

[Service]
Type=simple
ExecStart=/usr/bin/rfkill unblock all

[Install]
WantedBy=suspend.target
EOF
