# Media

## Prerequisites

- docker
- nfs_common (optional, for nfs shares)
- make (optional, for shorter commands)

## Setup

Recommended to set up on a Linux server.

1. Ensure docker is installed

   For debian linux, run `./scripts/install_docker_deb.sh` or `make install_docker`

2. Setup Users, groups, directories and shares. Edit before using

   `./scripts/setup.sh` or `make setup`

3. If using NFS, ensure is configured properly and running.

4. Bring up media center containers

   `docker compose up -d` or 

   To take it down, `docker compose down`

## Folder Structure

```
├── data
  ├── torrents     # torrents NFS share
  │  ├── movies
  │  └── series
  └── media
     ├── movies    # movies NFS share
     └── series    # series NFS share
├── config
  ├── sonarr
  ├── radarr
  ├── prowlarr
  ├── qbittorrent
  ├── overseerr
  └──...
```

## Env vars

Stored in `.env`

| Key | Value | Description |
| --- | --- | --- |
| TZ | "Australia/Sydney" | Timezone |
| UMASK | 0002 | UMask value |
| IP | "192.168.1.27" | Host IP address, updated by `setup.sh` |
| BASE_DIR | "/home/cg/media" | Base directory path of media repo, updated by `setup.sh` |
| UID | 1000 | User ID, updated by `setup.sh` |
| GID | 1000 | Group ID, updated by `setup.sh` |

## Plex claim

Enter plex claim in `plex_claim.txt`. Get by visiting here https://www.plex.tv/claim.

## Ports

These are the ports running for each service, most are defaults.

| Service | Host Port |
| --- | --- |
| Sonarr | 8989 (UI) | 
| Radarr | 7878 (UI) | 
| Prowlarr | 9696 (UI) | 
| qBittorrent | 8080 (UI)<br>6881 (default, changed to higher port)<br>60881 (new custom port) | 
| Overseerr | 5055 (UI) | 
| Nginx Proxy Manager | 81 (UI)<br>80 (HTTP)<br>443 | 


## NFS

Run `setup.sh` with the nfs vars configured for the environment to:
- Add nfs shares to fstab
- Add nfs service dependency for docker to ensure

## DNS

To set custom zone, add zone to `named.conf` and add zone file reference in folder, eg. `example-com.zone`.

Before running the container you may need to disable the host systems dns which is occupying port 53 on the host. On Ubuntu Linux:

1. Open `/etc/systemd/resolved.conf`, uncomment and set value `DNSStubListenerExtra=No`

2. Restart systemd resolved: `systemctl restart systemd-resolved`

## NordVPN

Get Nordvpn SOCKS servers PowerShell command:

```Powershell
$nordservers = Invoke-WebRequest -Uri https://nordvpn.com/api/server -UseBasicParsing -Method GET | ConvertFrom-Json

$nordservers | Where-Object features -match "socks=True" | Select-Object name, domain, load | Sort-Object name
```

## Resources

- https://trash-guides.info/Hardlinks/How-to-setup-for/Docker/
