#!/bin/bash
set -e

# Setup timezone environment
export TZ="Europe/Paris"
echo $TZ >/etc/timezone
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Update package list
apt update
apt upgrade -y

# Install basic tools
apt install --no-install-recommends -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    software-properties-common \
    wget \
    git \
    vim \
    nano \
    zip \
    unzip 
    

# Install Docker without Docker Desktop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io

# Configure Docker socket to run on WSl
echo "{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}" >> /etc/docker/daemon.json


# Install kubectl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y kubectl

# Install HELM
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Azure CLI 
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install additional tools
apt install -y \
    python3 \
    python3-pip \
    nodejs \
    npm

# Clean up
apt clean