# Media

## Prerequisites

- docker
- nfs_common (optional, for nfs shares)
- make (optional, for shorter commands)

## Setup

1. Ensure docker is installed

   For debian linux, run `./scripts/install_docker_deb.sh` or `make install_docker`

2. Setup Users, groups, directories and shares.

   `./scripts/setup.sh` or `make setup`

## Folder Structure

```
├── data
  ├── torrents
  │  ├── movies
  │  └── series
  └── media
     ├── movies   # movies NFS share
     └── series   # movies NFS share
├── config
  ├── sonarr
  ├── radarr
  ├── prowlarr
  ├── qbittorrent
  └── overseerr
```

## Env vars

Stored in `.env`

| Key | Value | Description |
| --- | --- | --- |
| UID | 1000 | User ID |
| TZ | "Australia/Sydney" | Timezone |
| UMASK | 0002 | UMask value |
| PLEX_CLAIM | "claim-q3omNzt2fjzyKR84bQRv" | plex claim, current one is old and triggers login |
| IP | "192.168.1.27" | Host IP address |
| HOSTNAME | "Plexy" | Plex hostname |
| BASE_DIR | "/home/cg/media" | Base directory path of media repo |
