#!/bin/sh

sudo pacman -S pipewire pipewire-pulse wireplumber pavucontrol pamixer sof-firmware
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
