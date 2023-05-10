#!/bin/bash

# base directory for folders
script_path="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"
parent_dir="$(dirname "${script_path}")"

# NFS vars, comment out to disable
nfs_server="192.168.1.10"
nfs_share_base_path="/mnt/vol0/media"
nfs_mount_base_path="${parent_dir}/data"

create_dirs() {
  # Make directories
  sudo mkdir -pv "${parent_dir}"/config/{sonarr,radarr,prowlarr,qbittorrent,overseerr}
  sudo mkdir -pv "${parent_dir}"/data/{torrents,media}/{series,movies}
}

nfs() {

  # check nfs server provider
  [ -z "$1" ] && echo "Skipping NFS setup, no server provided" && return

  nfs_server=$1
  nfs_share_base_path=$2
  nfs_mount_base_path=$3

  if ! command -v which tee &> /dev/null; then
    echo "tee not found, installing"
    sudo apt install tee -y
  fi

  # Add nfs shares to fstab
  # configured for 128KB record sizes
  printf "%s %s %s %s 0 0" "${nfs_server}:${nfs_share_base_path}/movies" "${nfs_mount_base_path}/media/movies" "nfs" "rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3" | sudo tee -a /etc/fstab
  printf "%s %s %s %s 0 0" "${nfs_server}:${nfs_share_base_path}/series" "${nfs_mount_base_path}/media/series" "nfs" "rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3" | sudo tee -a /etc/fstab
  printf "%s %s %s %s 0 0" "${nfs_server}:${nfs_share_base_path}/torrents" "${nfs_mount_base_path}/torrents" "nfs" "rw,noatime,rsize=131072,wsize=131072,hard,intr,timeo=150,retrans=3" | sudo tee -a /etc/fstab

  # add nfs service dependency for docker to ensure
  # nfs shares are mounted before containers start
  sudo mkdir /etc/systemd/system/docker.service.d/
  printf "%s\n" \
    "[Unit]" \
    "Requires=$(sudo systemctl list-units | grep series.mount | awk '{print $1}') $(sudo systemctl list-units | grep movies.mount | awk '{print $1}') $(sudo systemctl list-units | grep torrents.mount | awk '{print $1}')" \
    "Wants=$(sudo systemctl list-units | grep series.mount | awk '{print $1}') $(sudo systemctl list-units | grep movies.mount | awk '{print $1}') $(sudo systemctl list-units | grep torrents.mount | awk '{print $1}')" \
  | sudo tee -a /etc/systemd/system/docker.service.d/wait-for-nfs.conf

}

set_permissions() {
  # Set permissions
  sudo chmod -R 775 "${parent_dir}"/{data,media}
  sudo chown -R "$(id -u)":"$(id -g)" "${parent_dir}"/{data,media}
}

update_uid_env() {
  # add vars to .env file
  printf "IP=%s" "$(hostname -I | awk '{print $1}')" | tee -a "${parent_dir}"/.env
  printf "BASE_DIR=%s" "${1}" | tee -a "${parent_dir}"/.env
  printf "UID=%s" "$(id -u)" | tee -a "${parent_dir}"/.env
  printf "GID=%s" "$(id -g)" | tee -a "${parent_dir}"/.env
}


# Start
create_dirs
nfs "${nfs_server}" "${nfs_share_base_path}" "${nfs_mount_base_path}"
set_permissions
update_uid_env "${parent_dir}"
