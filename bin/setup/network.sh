#!/usr/bin/sh

sudo pacman -Sy openssl ntp dnsmasq

echo "nameserver 127.0.0.1"    | sudo tee /etc/resolv.conf.head
echo address=/.local/127.0.0.1 | sudo tee -a /etc/dnsmasq.conf
echo address=/.doc/127.0.0.1   | sudo tee -a /etc/dnsmasq.conf

sudo systemctl start sshd
sudo systemctl start ntpd.service
sudo systemctl start dnsmasq

sudo systemctl enable sshd
sudo systemctl enable ntpd.service
sudo systemctl enable dnsmasq

echo "manually enable netct-auto 'sudo systemctl enable netctl-auto@wlp3s0.service'"
