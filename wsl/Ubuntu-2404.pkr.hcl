packer {
  required_plugins {
    qemu = {
      version = "~> 1"
      source  = "github.com/hashicorp/qemu"
    }
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "image_name" {
  type    = string
  default = "Ubuntu-2204-wsl-DevOps"
}

source "qemu" "ubuntu" {
  iso_url      = "http://releases.ubuntu.com/24.04/ubuntu-24.04.1-live-server-amd64.iso"
  iso_checksum = "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"
  ssh_username = "DevOps"
}


build {
  sources = ["source.qemu.ubuntu"]
  
  provisioner "shell" {
    environment_vars = [
      "username=DevOps",
    ]
    inline = [
      # Update and install tools
      "sudo apt-get update",
      "sudo apt-get install -y git",
      
      # Add user to docker group to avoid permission issues
      "sudo usermod -aG docker $username",
      
      # Install other tools
      # Additional installations can go here as needed
      
      # Clean up to reduce image size
      "sudo apt-get clean",
      "sudo rm -rf /var/lib/apt/lists/*"
    ]
  }

  post-processor "docker-import" {
    repository = var.image_name
    tag        = "latest"
  }
  
}
