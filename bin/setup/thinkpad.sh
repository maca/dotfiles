#!/usr/bin/sh

aur -si tp-battery-mode
sudo pacman -S xss-lock
sudo systemctl start tp-battery-mode
sudo systemctl enable tp-battery-mode

sudo sh -c "cat > /etc/X11/xorg.conf.d/20-intel.conf" <<EOF
Section "Device"
  Identifier  "Intel Graphics"
  Driver      "i915"
  Option      "TearFree" "true"
  Option      "AccelMod" "uxa"
  Option      "DRI"      "3"
EndSection
EOF


# https://wiki.archlinux.org/index.php/laptop#Hibernate_on_low_battery_level
sudo sh -c "cat > /etc/udev/rules.d/lowbat.rules" <<EOF
SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="/usr/bin/systemctl suspend"
EOF



# Rfkill unblock on resume
sudo sh -c "cat > /etc/systemd/system/resume-root.service" <<EOF
[Unit]
Description=Resume actions
After=suspend.target

[Service]
Type=simple
ExecStart=/usr/bin/rfkill unblock all

[Install]
WantedBy=suspend.target
EOF
sudo systemctl enable resume-root
