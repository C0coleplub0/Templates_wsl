#!/bin/bash
echo -e "===> Install Docker without Docker Desktop \n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io -y

echo -e "===> Configure Docker socket to run on WSl \n"
echo "{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}" >> /etc/docker/daemon.json
