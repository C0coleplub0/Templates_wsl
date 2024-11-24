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
  default = null
}

variable "distribution" {
  type    = string
  default = null
}

variable "username" {
  type    = string
  default = null
}

variable "output_image_name" {
  type    = string
  default = null
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
    environment_vars = [
      "USERNAME=${var.username}",
      "DISTRIBUTION=${var.distribution}"
    ]
    scripts = [
      "scripts/setup_basic.sh",
      "scripts/setup_docker.sh",
      "scripts/setup_kubectl.sh"
    ]
  }




}


