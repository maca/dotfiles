#!/usr/bin/sh

# run as root - fix: with sudo!
sudo pacman -Sy postgresql

sudo systemd-tmpfiles --create postgresql.conf
sudo mkdir -p /var/lib/postgres/data
sudo chown -c -R postgres:postgres /var/lib/postgres
sudo su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo su - postgres -c "createuser -s -U postgres --interactive"
