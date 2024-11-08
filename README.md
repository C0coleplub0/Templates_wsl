# Packer templates

Packer templates for WSL (Windows Subsystem for Linux).

Thoses templates are builded to contains and pre configure usefull tools for DevOps such as :

* Docker
* Kubectl
* Azure cli
* git
* And much more

## Build prerequisites

Run the `install_packer.sh` script to install HashiCorp Packer on Debian base Linux. (Works on Ubuntu)

## Build images 

Run `packer build .` in the wsl directory and that's it.

## Import .tar image

Run `wsl --import DevOps-ubuntu E:\DevOps-ubuntu .\DevOps-Ubuntu-2404.tar`