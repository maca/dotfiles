#!/usr/bin/sh

read -p "what is the wifi inteface?" interface
read -p "what is the access point password" password


aur -si rtl88xxau-aircrack-dkms-git nginx-mod-dav-ext
sudo pacman -Sy cmus dnsmasq hostapd wireguard-dkms wireguard-tools apache-tools


sudo sh -c "cat > /etc/systemd/network/$interface.network" <<EOF
[Match]
Name=$interface

[Network]
Address=192.168.90.1/24
EOF


sudo sh -c "cat > /etc/hostapd.conf" <<EOF
interface=$interface
driver=nl80211

# hw_mode=a
# ieee80211d=1
## IEEE 802.11n
## IEEE 802.11a
#hw_mode=a
## IEEE 802.11a
## IEEE 802.11ac
#ieee80211ac=1
# channel=36
country_code=US

hw_mode=a
ieee80211n=1
require_ht=1
ieee80211ac=1
channel=40

# require_vht=1
# require_ht=1
vht_oper_chwidth=1
vht_oper_centr_freq_seg0_idx=42
ht_capab=[HT40-][SHORT-GI-40][SHORT-GI-40][DSSS_CCK-40]
vht_capab=[MAX-MPDU-11454][SHORT-GI-80][TX-STBC-2BY1][RX-STBC-1][MAX-A-MPDU-LEN-EXP3]
vht_oper_chwidth=1

ssid=$(cat /etc/hostname)
wmm_enabled=1
wpa=2
preamble=1
wpa_passphrase=$password
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
auth_algs=1
macaddr_acl=0

# controlling enabled
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0

# logging
logger_syslog=0
logger_syslog_level=0
EOF
sudo systemd start hostapd
sudo systemd enable hostapd


sudo sh -c "cat > /etc/dnsmasq.conf" <<EOF
# listen-address=127.0.0.1
# disables dnsmasq reading any other files like /etc/resolv.conf for nameservers
no-resolv
# Interface to bind to
interface=$interface
# Specify starting_range,end_range,lease_time
dhcp-range=192.168.90.3,192.168.90.30,255.255.255.0,12h
# dns addresses to send to the clients
server=10.8.0.1
server=193.138.218.74
EOF
sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq


sudo sh -c "cat > /etc/nginx/nginx.conf" <<EOF
#user html;
worker_processes  1;

error_log  /var/log/nginx/error.log info;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;
#pid        logs/nginx.pid;

load_module /usr/lib/nginx/modules/ngx_http_dav_ext_module.so;

events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    #access_log  logs/access.log  main;
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_buffers 16 8k;
    gzip_http_version 1.1;
    # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    #gzip  on;
    server {
      listen 8080;

      auth_basic              realm_name;
      auth_basic_user_file    /etc/nginx/passwords;

      dav_methods     PUT DELETE MKCOL COPY MOVE;
      dav_ext_methods PROPFIND OPTIONS LOCK UNLOCK;
      dav_access      user:rw group:rw all:r;
      autoindex on;

      client_body_temp_path   /tmp/client-bodies;
      client_max_body_size    0;
      create_full_put_path    on;

      root /media/ext;
    }
}
EOF
echo "Provide a webdav password:"
sudo htpasswd -c /etc/nginx/passwords $(whoami)
sudo systemctl start nginx
sudo systemctl enable nginx


curl -LO https://mullvad.net/media/files/mullvad-wg.sh && chmod +x ./mullvad-wg.sh && ./mullvad-wg.sh
read -r -d '' rules <<-EOF
PostUp = iptables -t nat -A POSTROUTING -o %i -j MASQUERADE; iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT; iptables -A FORWARD -i wlan0 -o %i -j ACCEPT;\\nPostDown = iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT; iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
EOF
for file in $(sudo ls /etc/wireguard); do sudo sed "/^DNS =.*/a ${rules}" $file; done
sudo systemctl start wg-quick@mullvad-ro1
sudo systemctl enable wg-quick@mullvad-ro1


