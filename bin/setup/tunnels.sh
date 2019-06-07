#!/usr/bin/sh

sudo ssh-keygen -q -t rsa -C "root@$(cat /etc/hostname)" -f /root/.ssh/tunnel_rsa
sudo cat /root/.ssh/tunnel_rsa.pub

sudo sh -c "cat > /etc/systemd/system/tunnel@.service" <<EOF
[Unit]
Description=SSH tunnel for %I
After=network.target

[Service]
Environment="ARGS=%I"
ExecStartPre=/bin/sleep 30
ExecStart=/home/maca/bin/tunnel \$ARGS
StandardOutput=syslog
StandardError=syslog
Restart=on-failure
RestartSec=300

[Install]
WantedBy=default.target
EOF
