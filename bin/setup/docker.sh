#!/usr/bin/sh

sudo pacman -Sy docker docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $(whoami)
newgrp docker
