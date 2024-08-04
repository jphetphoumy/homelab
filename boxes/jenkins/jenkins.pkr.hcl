packer {
  required_plugins {
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}


source "proxmox-clone" "jenkins-baseline" {
  proxmox_url              = var.proxmox_url
  username                 = var.proxmox_username
  token                    = var.proxmox_token
  insecure_skip_tls_verify = true
  node                     = "proxmox"
  tags                     = "ci-cd"

  qemu_agent = true

  ssh_username = "root"

  clone_vm   = "debian-bookworm"
  vm_name    = "jenkins-baseline"
  cores      = 2
  os         = "l26"
  memory     = "4096"

  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = false
  }

  ipconfig {
    ip      = "192.168.1.110/24"
    gateway = "192.168.1.1"
  }

  # Cloud init
  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"
}

build {
  name = "jenkins"
  sources = [
    "source.proxmox-clone.jenkins-baseline"
  ]
  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    script = "./scripts/provision.sh"
  }
}
