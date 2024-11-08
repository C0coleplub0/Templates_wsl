#!/bin/bash
set -e

# Setup timezone environment
export TZ="Europe/Paris"
echo $TZ > /etc/timezone


echo -e "===> Update package list\n"
apt update


# Install basic tools
echo -e "===> Install basic tools\n"
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
    
    

echo -e "===> Install Docker without Docker Desktop \n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io -y

echo -e "===> Configure Docker socket to run on WSl \n"
echo "{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}" >> /etc/docker/daemon.json



echo -e "===> Install kubectl \n"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/sources.list.d/kubernetes.list 
apt update
apt install -y kubectl



echo -e "===> Install HELM \n"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash



echo -e "===> Install Azure CLI \n"
curl -sL https://aka.ms/InstallAzureCLIDeb | bash



echo -e "===> Install additional tools \n"
apt install -y \
  python3 \
  python3-pip \
  nodejs \
  npm



echo -e "===> Clean up \n"
apt clean
echo "" > /etc/fstab