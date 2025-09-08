#!/bin/bash
set -e

# Setup timezone environment
export TZ="Europe/Paris"
echo $TZ > /etc/timezone


echo -e "\n===> Update package list\n"
apt update


# Install basic tools
echo -e "\n===> Install basic tools\n"
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
    unzip \
    wget \
    gpg \
    neofetch \
    zsh 

echo "neofetch" >> /etc/profile

echo -e "\n===> Install VSCode \o/\n"

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg
apt install apt-transport-https -y 
#!/usr/bin/env bash
set -euo pipefail

cat << 'EOF' | tee /etc/apt/sources.list.d/vscode.sources > /dev/null
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

apt update -y 
apt install code -y


echo -e "\n===> Install Oh My Zsh ! \n" 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


if [-z $USERNAME];
then
  echo -e "\n===> Error Username vars isn't defined"
else
  echo -e "\n===> Username vars is defined and contains : $USERNAME\n"
  useradd -m -s /bin/zsh $USERNAME
  echo "$USERNAME:password" | chpasswd
  usermod -aG sudo "$USERNAME"
  groupadd docker
  usermod -aG docker "$USERNAME"
  chsh -s /usr/bin/zsh $USERNAME
  cat <<EOF > /etc/wsl.conf
  [user]
  default=$USERNAME
EOF
fi

echo -e "\n===> Install additional tools \n"
apt install -y \
  python3 \
  python3-pip 

echo -e "\n===> Clean up \n"
apt clean
