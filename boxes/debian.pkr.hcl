packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_url" {
    type = string
}

variable "proxmox_token" {
  type = string
}

variable "proxmox_username" {
  type = string
}

source "proxmox-iso" "debian-bookworm" {
    proxmox_url = var.proxmox_url
    username = var.proxmox_username 
    token = var.proxmox_token
    insecure_skip_tls_verify = true
    node = "proxmox"

    iso_checksum = "33c08e56c83d13007e4a5511b9bf2c4926c4aa12fd5dd56d493c0653aecbab380988c5bf1671dbaea75c582827797d98c4a611f7fb2b131fbde2c677d5258ec9"
    #iso_url =  "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
    iso_file = "local:iso/debian-12.5.0-amd64-netinst.iso"
    iso_storage_pool = "local"

    # VM Network Settings
    network_adapters {
      model = "virtio"
      bridge = "vmbr0"
      firewall = false
    }

    # VM disk
    disks {
      disk_size = "5G"
      storage_pool = "local-lvm"
      type = "scsi"
    }

    memory = "2048"

    efi_config {
      efi_storage_pool = "local-lvm"
      efi_type = "4m"
      pre_enrolled_keys = true
    }

    # Preseed
    http_directory = "http"

    boot_command = [
        "<esc><wait>",
        "install <wait>",
        " auto=true",
        " priority=critical",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>",
        " -- <wait>",
        "<enter><wait>"
    ]

    boot_wait = "10s"

    # SSH Configuration
    ssh_username = "packer"
    ssh_password = "packer"
    ssh_timeout = "15m"

    http_bind_address = "192.168.1.120"

    unmount_iso = true
    
}

build {
  name = "debian-bookworm"
  sources = [
    "source.proxmox-iso.debian-bookworm"
  ]
}