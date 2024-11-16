# Packer templates

Packer templates for WSL (Windows Subsystem for Linux).

Thoses templates are builded to contains and pre configure usefull tools for DevOps such as :

* Docker
* zsh
    * OhMyZsh
* Kubectl
    * k9s
    * helm
* Azure cli
* git
* And much more

## Build prerequisites

Run the `install_packer.sh` script to install HashiCorp Packer on Debian base Linux. (Works on Ubuntu)

## Define your own variables

The file `*.auto.pkrvars.hcl` can help you to setup some features as username or even source docker image. 
Feel free to edit it as you need

## Build images 

Run `packer build .` in the wsl directory and that's it.

## Import .tar image

Run `wsl --import DevOps-ubuntu E:\DevOps-ubuntu .\DevOps-Ubuntu-2404.tar`


## WIP

The workflow does not work for now. 

Later it will create and publish the tar packages