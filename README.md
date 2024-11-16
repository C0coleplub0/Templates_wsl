# Packer templates

Packer templates for WSL (Windows Subsystem for Linux).

Thoses templates are builded to contains and pre configure usefull tools for DevOps

## Supported products

|Product              | installed by default  | Upcoming link                                         |
|---------------------|:---------------------:|-------------------------------------------------------|
| Docker🐳            | yes                   | [Documentation](https://docs.docker.com/get-started/) |
| Visual Studio Code  | yes                   |                                                       |
| zsh                 | yes                   |                                                       |
| OhMyZsh             | yes                   | [Github repo](https://docs.docker.com/get-started/)   |
| Kubectl             | yes                   |                                                       |
| K9s🐶               | yes                   | [Github repo](https://github.com/derailed/k9s)        |
| helm                | yes                   |                                                       |
| Azure cli           | no                    |                                                       |
| gcloud cli          | no                    |                                                       |
| git                 | yes                   |                                                       |
| Python3🐍           | yes                   |                                                       |


## Local Build prerequisites

Run the `install_packer.sh` script to install HashiCorp Packer on Debian base Linux. (Works on Ubuntu)

### Define your own variables

The file `*.auto.pkrvars.hcl` can help you to setup some features as username or even source docker image. 
Feel free to edit it as you need

### Customize settings

You can go through `wsl/scripts/setup.basic.sh` to override the TimeZone settings or the default shell. 

If you don't, zsh will be the default shell and Europe/Paris the default timezone

## Building images 

Run `packer build .` in the wsl directory and that's it.

## Import .tar image

Run `wsl --import DevOps-ubuntu E:\DevOps-ubuntu .\DevOps-ubuntu.tar`


## WIP

The workflow does not work for now. 

Later it will create and publish the tar packages