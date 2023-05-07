#!/bin/bash

# base directory for folders
script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
parent_dir="$(dirname "${script_path}")"

create_users_groups() {
  # Make users and group
  sudo useradd sonarr -u 3001
  sudo useradd radarr -u 3002
  sudo useradd prowlarr -u 3003
  sudo useradd jackett -u 3004
  sudo useradd qbittorrent -u 3005
  sudo useradd overseerr -u 3006
  sudo groupadd mediacenter -g 3000
  sudo usermod -a -G mediacenter sonarr
  sudo usermod -a -G mediacenter radarr
  sudo usermod -a -G mediacenter prowlarr
  sudo usermod -a -G mediacenter qbittorrent
  sudo usermod -a -G mediacenter jackett
  sudo usermod -a -G mediacenter overseerr
}

create_dirs() {
  # Make directories
  sudo mkdir -pv ${parent_dir}/config/{sonarr,radarr,prowlarr,jackett,qbittorrent,overseerr}
  sudo mkdir -pv ${parent_dir}/data/{torrents,media}/{series,movies}
}

nfs() {
  # Add nfs shares to fstab
  nfs_server="192.168.1.10"
  nfs_share_base_path="/mnt/vol0/media"
  nfs_mount_base_path="${parent_dir}/data"
  sudo echo "${nfs_server}:${nfs_share_base_path}/movies ${nfs_mount_base_path}/media/movies nfs rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3 0 0" >> /etc/fstab
  sudo echo "${nfs_server}:${nfs_share_base_path}/series ${nfs_mount_base_path}/media/series nfs rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3 0 0" >> /etc/fstab
  sudo echo "${nfs_server}:${nfs_share_base_path}/torrents ${nfs_mount_base_path}/torrents nfs rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3 0 0" >> /etc/fstab
}

set_permissions() {
  # Set permissions
  sudo chmod -R 775 "${parent_dir}/data/"
  sudo chown -R $(id -u):mediacenter "${parent_dir}/data/"
  sudo chown -R sonarr:mediacenter "${parent_dir}/config/sonarr"
  sudo chown -R radarr:mediacenter "${parent_dir}/config/radarr"
  sudo chown -R prowlarr:mediacenter "${parent_dir}/config/prowlarr"
  sudo chown -R jackett:mediacenter "${parent_dir}/config/jackett"
  sudo chown -R qbittorrent:mediacenter "${parent_dir}/config/qbittorrent"
  sudo chown -R overseerr:mediacenter "${parent_dir}/config/overseerr"
}

update_uid_env() {
  echo "UID=$(id -u)" >> "${parent_dir}/.env"
}


# Start
create_users_groups
create_dirs
nfs
set_permissions
update_uid_env
