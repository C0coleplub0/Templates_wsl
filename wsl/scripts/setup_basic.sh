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
    zsh 

# echo -e "\n===> Install VSCode \o/\n"

# wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
# add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
# apt update -y && apt install code -y

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
fi

echo -e "\n===> Install additional tools \n"
apt install -y \
  python3 \
  python3-pip \
  nodejs \
  npm

echo -e "\n===> Clean up \n"
apt clean
