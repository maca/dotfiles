#!/usr/bin/sh
# not tested


pacman -Sy transmission

sudo mkdir /data
sudo chmod -R 775 /data
chown -R maca:transmission /data
sudo chown -R maca:users /data
mkdir /data/torrents
sudo chown -R maca:transmission /data/torrents

sudo systemctl start transmission
sudo systemctl stop transmission

sed -i 's|/var/lib/transmission/Downloads|/data/torrents|' \
    /var/lib/transmission/.config/transmission-daemon/settings.json
