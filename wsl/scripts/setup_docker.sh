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
cat << EOF >> /home/$USERNAME/.bashrc
  mkdir -pm o=,ug=rwx "/mnt/wsl/shared-docker"
  export DOCKER_HOST="unix:///mnt/wsl/shared-docker/docker.sock"
  if [ ! -S "/mnt/wsl/shared-docker/docker.sock" ]; then
      mkdir -pm o=,ug=rwx "/mnt/wsl/shared-docker"
      chgrp docker "/mnt/wsl/shared-docker"
      /mnt/c/Windows/System32/wsl.exe -d $DISTRIBUTION sh -c "nohup sudo -b dockerd < /dev/null > /mnt/wsl/shared-docker/dockerd.log 2>&1"
  fi
EOF

# Same config for .zshrc script to run Docker daemon
cat << EOF >> /home/$USERNAME/.zshrc
  mkdir -pm o=,ug=rwx "/mnt/wsl/shared-docker"
  export DOCKER_HOST="unix:///mnt/wsl/shared-docker/docker.sock"
  if [ ! -S "/mnt/wsl/shared-docker/docker.sock" ]; then
      mkdir -pm o=,ug=rwx "/mnt/wsl/shared-docker"
      chgrp docker "/mnt/wsl/shared-docker"
      /mnt/c/Windows/System32/wsl.exe -d $DISTRIBUTION sh -c "nohup sudo -b dockerd < /dev/null > /mnt/wsl/shared-docker/dockerd.log 2>&1"
  fi
EOF