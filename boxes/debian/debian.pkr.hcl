packer {
  required_plugins {
    name = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "debian-bookworm" {
  proxmox_url              = var.proxmox_url
  username                 = var.proxmox_username
  token                    = var.proxmox_token
  insecure_skip_tls_verify = true
  node                     = "proxmox"
  vm_id = 100


  iso_checksum = "33c08e56c83d13007e4a5511b9bf2c4926c4aa12fd5dd56d493c0653aecbab380988c5bf1671dbaea75c582827797d98c4a611f7fb2b131fbde2c677d5258ec9"
  iso_file         = "local:iso/debian-12.5.0-amd64-netinst.iso"
  iso_storage_pool = "local"

  #VM Configuration
  vm_name = "debian-bookworm"
  cores   = 2
  os      = "l26"

  # VM Network Settings
  network_adapters {
    model    = "virtio"
    bridge   = "vmbr0"
    firewall = false
  }

  # VM disk
  disks {
    disk_size    = "5G"
    storage_pool = "local-lvm"
    type         = "scsi"
  }

  memory = "2048"

  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }

  # Preseed
  http_directory = "http"

  boot_command = [
    "<esc><wait>",
    "install <wait>",
    " auto=true",
    " priority=critical",
    " preseed/url=http://${var.http_ip}:${var.http_port}/preseed.cfg<wait>",
    " -- <wait>",
    "<enter><wait>"
  ]

  boot_wait = "10s"

  # SSH Configuration
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "20m"

  http_port_min = var.http_port
  http_port_max = var.http_port

  unmount_iso = true

  # Cloud init
  cloud_init              = true
  cloud_init_storage_pool = "local-lvm"
}

build {
  name = "debian-bookworm"
  sources = [
    "source.proxmox-iso.debian-bookworm"
  ]
}
