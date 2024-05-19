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

source "proxmox-iso" "nixos" {
  proxmox_url              = var.proxmox_url
  username                 = var.proxmox_username
  token                    = var.proxmox_token
  insecure_skip_tls_verify = true
  node                     = "proxmox"
  vm_id = 101


  iso_checksum = "sha256:cf600740933b3cfe08197510d4128ea3072b6aacf575473e65d5575facaec55b"
  #iso_url =  "https://channels.nixos.org/nixos-24.05/latest-nixos-minimal-x86_64-linux.iso"
  iso_file         = "local:iso/latest-nixos-minimal-x86_64-linux.iso"
  iso_storage_pool = "local"

  #VM Configuration
  vm_name = "nixos"
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
    disk_size    = "50G"
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
  http_interface = "Wi-Fi"
  boot_command = [
    "<enter><wait30>",
    "passwd<enter>",
    "nixos<enter>",
    "nixos<enter>",
    "sudo -i<enter><wait>",
    "export REMOTE_HTTP=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<enter><wait>",
    "curl $REMOTE_HTTP/provision.sh| sh<enter>",
  ]

  boot_wait = "5s"

  # SSH Configuration
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_timeout  = "10m"

  #http_bind_address = "192.168.1.120"

  unmount_iso = true

  # Cloud init
  # cloud_init              = true
  # cloud_init_storage_pool = "local-lvm"
}

build {
  name = "nixos"
  sources = [
    "source.proxmox-iso.nixos"
  ]
}