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

echo -e "===> Install additional tools \n"
apt install -y \
  python3 \
  python3-pip \
  nodejs \
  npm

echo -e "===> Clean up \n"
apt clean
