#!/bin/bash
echo -e "===> Install kubectl \n"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg 
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/sources.list.d/kubernetes.list 
apt update
apt install -y kubectl

echo -e "===> Install HELM \n"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo -e "===> Install k9s \n"
wget -q https://github.com/derailed/k9s/releases/download/v0.32.5/k9s_linux_amd64.deb 
dpkg -i k9s_linux_amd64.deb