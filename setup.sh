#!/bin/bash

# base directory for folders
base_dir="/mnt/media"

# Make users and group
sudo useradd sonarr -u 13001
sudo useradd radarr -u 13002
sudo useradd prowlarr -u 13006
sudo useradd qbittorrent -u 13007
sudo useradd jackett -u 13008
sudo useradd overseerr -u 13009
sudo groupadd mediacenter -g 13000
sudo usermod -a -G mediacenter sonarr
sudo usermod -a -G mediacenter radarr
sudo usermod -a -G mediacenter prowlarr
sudo usermod -a -G mediacenter qbittorrent
sudo usermod -a -G mediacenter jackett
sudo usermod -a -G mediacenter overseerr

# Make directories
sudo mkdir -pv ${base_dir}/config/{sonarr,radarr,prowlarr,qbittorrent,jackett,overseerr}
sudo mkdir -pv ${base_dir}/data/{torrents,media}/{tv,movies}

# Set permissions
sudo chmod -R 775 ${base_dir}/data/
sudo chown -R $(id -u):mediacenter ${base_dir}/data/
sudo chown -R sonarr:mediacenter ${base_dir}/config/sonarr
sudo chown -R radarr:mediacenter ${base_dir}/config/radarr
sudo chown -R prowlarr:mediacenter ${base_dir}/config/prowlarr
sudo chown -R qbittorrent:mediacenter ${base_dir}/config/qbittorrent
sudo chown -R jackett:mediacenter ${base_dir}/config/jackett
sudo chown -R overseerr:mediacenter ${base_dir}/config/overseerr

echo "UID=$(id -u)" >> .env

# nfs
echo "192.168.1.10:/mnt/v1_rz2/media ${base_dir} nfs rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3 0 0" >> /etc/fstab
