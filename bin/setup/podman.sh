#!/usr/bin/sh


pacman -S buildah podman podman-dnsname fuse-overlayf dnsmasq


sudo sh -c "cat > /etc/resolv.conf" <<EOF
nameserver ::1
nameserver 127.0.0.1
options trust-ad%
EOF


echo 'buildah:100000:65536' | sudo tee /etc/subuid
echo 'buildah:100000:65536' | sudo tee /etc/subgid


sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $(whoami)


systemctl disable --now systemd-resolved
systemctl enable --now dnsmasq
systemctl --user enable --now podman
