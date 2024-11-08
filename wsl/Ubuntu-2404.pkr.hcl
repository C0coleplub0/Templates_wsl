packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

  source "docker" "ubuntu" {
    image  = "ubuntu:24.04"
    commit = true
    changes = [
      "ENTRYPOINT [\"/bin/bash\"]"
    ]
  }

  build {
    name = "custom-wsl"
    sources = ["source.docker.ubuntu"]

    provisioner "shell" {
      scripts = [
        "scripts/setup_basic.sh",
        "scripts/setup_docker.sh",
        "scripts/setup_kubectl.sh"
      ]
    }

  post-processor "docker-save" {
    path     = "DevOps-Ubuntu-2404.tar"
  }
  
}
