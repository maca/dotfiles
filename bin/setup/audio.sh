#!/bin/sh

pacman -S pipewire pipewire-pulse wireplumber pavucontrol pamixer
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
