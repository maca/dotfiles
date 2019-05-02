#!/usr/bin/sh

aur -si tp-battery-mode
sudo systemctl start tp-battery-mode
sudo systemctl enable tp-battery-mode
