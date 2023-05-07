#!/bin/bash

# cleanup
echo "removing old docker installation"
sudo apt-get remove docker docker-engine docker.io containerd runc

# prereqs
echo "installing prereqs"
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg

# keys
echo "configuring keys"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
echo "installing docker"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# group config for user
echo "configuring docker group"
sudo groupadd docker
sudo usermod -aG docker $USER

# log size limit
echo "configuring docker log file"
echo '{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "50m",
    "max-file": "3" 
  }
}' > /etc/docker/daemon.json

# service
echo "enabling services"
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
