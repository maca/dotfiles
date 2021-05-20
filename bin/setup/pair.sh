#!/usr/bin/sh

sudo useradd -m -s /bin/sh pair
sudo useradd -m -s /bin/sh observer

sudo sh -c "cat >> /etc/ssh/sshd_config" <<EOF

Match User pair
      ForceCommand tmux -S /tmp/tmux-sessions/tmux attach -t tmux

Match User observer
      ForceCommand tmux -S /tmp/tmux-sessions/tmux attach -r -t tmux
EOF
