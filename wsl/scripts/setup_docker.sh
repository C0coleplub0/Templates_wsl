#!/bin/bash
echo -e "\n===> Install Docker without Docker Desktop \n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io -y

echo -e "\n===> Configure Docker socket to run on WSl \n"
echo "{
  "host": ["unix:///var/run/docker.sock"]
}" >> /etc/docker/daemon.json
