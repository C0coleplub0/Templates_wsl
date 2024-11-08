#!/bin/bash
echo -e "Installation of packer on linux \n"

echo -e "Adding HashiCorp gpg Key \n"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

echo -e "Adding the official HashiCorp Linux repository \n"
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

echo -e "Update packages and install packer \n"
sudo apt-get update && sudo apt-get install packer