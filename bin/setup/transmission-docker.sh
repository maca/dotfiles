
sudo docker create \
  --name=transmission \
  --user "0:$(id -g)" \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Berlin \
  -p 9091:9091 \
  -p 51413:51413 \
  -p 51413:51413/udp \
  -v /media/ext/transmission/conf:/config \
  -v /media/ext/transmission/downloads:/downloads \
  -v /media/ext/transmission/incomplete:/incomplete \
  -v /media/ext/transmission/watch:/watch \
  --restart unless-stopped \
  linuxserver/transmission

sudo docker start transmission
