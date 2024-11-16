#!/bin/bash
echo -e "\n===> Install Docker without Docker Desktop \n"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu noble stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io -y

echo -e "\n===> Configure Docker socket to run on WSl \n"
echo "{
  "hosts": ["unix:///mnt/wsl/shared-docker/docker.sock"]
}" >> /etc/docker/daemon.json

# Configure .bashrc script to run Docker daemon
cat << EOF >> ~/.bashrc
  DOCKER_DISTRO="Ubuntu" 
  DOCKER_DIR=/mnt/wsl/shared-docker
  mkdir -pm o=,ug=rwx "$DOCKER_DIR"
  DOCKER_SOCK="$DOCKER_DIR/docker.sock"
  export DOCKER_HOST="unix://$DOCKER_SOCK"
  if [ ! -S "$DOCKER_SOCK" ]; then
      mkdir -pm o=,ug=rwx "$DOCKER_DIR"
      chgrp docker "$DOCKER_DIR"
      /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
  fi
EOF

# Same config for .zshrc script to run Docker daemon
cat << EOF >> ~/.zshrc
  DOCKER_DISTRO="Ubuntu" 
  DOCKER_DIR=/mnt/wsl/shared-docker
  mkdir -pm o=,ug=rwx "$DOCKER_DIR"
  DOCKER_SOCK="$DOCKER_DIR/docker.sock"
  export DOCKER_HOST="unix://$DOCKER_SOCK"
  if [ ! -S "$DOCKER_SOCK" ]; then
      mkdir -pm o=,ug=rwx "$DOCKER_DIR"
      chgrp docker "$DOCKER_DIR"
      /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
  fi
EOF