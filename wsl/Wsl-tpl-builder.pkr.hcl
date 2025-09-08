packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "docker_image" {
  type    = string
  default = "ubuntu:24.04"
}

variable "distribution" {
  type    = string
  default = "Ubuntu"
}

variable "install_docker" {
  type    = bool
  default = true
}

variable "install_azcli" {
  type    = bool
  default = false
}

variable "install_gcloud" {
  type    = bool
  default = false
}

variable "username" {
  type    = string
  default = "coco"
}

variable "output_image_name" {
  type    = string
  default = "DevOps-ubuntu.tar"
}

source "docker" "image" {
  image       = var.docker_image
  export_path = "output/${var.output_image_name}"

  changes = [
    "USER ${var.username}",
    "WORKDIR /home/${var.username}"
  ]
}

build {
  name    = "custom-wsl"
  sources = ["source.docker.image"]

  provisioner "shell" {
    inline = ["echo Running build on ${var.docker_image} Docker image"]
  }
  
  provisioner "shell" {
    environment_vars = ["USERNAME=${var.username}", "DISTRIBUTION=${var.distribution}"]
    scripts = concat(
      ["${path.root}/scripts/setup_basic.sh"],
      ["${path.root}/scripts/setup_kubectl.sh"],
      # scripts optionnels
      var.install_docker  ? ["${path.root}/scripts/setup_docker.sh"]  : [],
      var.install_azcli ? ["${path.root}/scripts/setup_azcli.sh"] : [],
      var.install_gcloud  ? ["${path.root}/scripts/setup_gcloud.sh"]  : []
    )
  }

}


