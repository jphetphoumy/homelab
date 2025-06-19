// Define variables
variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "http_ip" {
  type      = string
  default = "192.168.1.120"
}

variable "http_port" {
    type = number
    default = 8336
}

packer {
  required_plugins {
    proxmox = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_url" {
  type    = string
  default = "https://192.168.1.213:8006/api2/json"
}

source "proxmox-iso" "gitlab" {
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

  http_port_min = var.http_port
  http_port_max = var.http_port
 
  tags = "gitlab" 
  efi_config {
    efi_storage_pool  = "local-lvm"
    efi_type          = "4m"
    pre_enrolled_keys = true
  }
  
  http_directory           = "config"
  insecure_skip_tls_verify = true
  
  disks {
    disk_size         = "40G"
    storage_pool      = "local-lvm"
    type              = "scsi"
    format = "raw"
  }

  boot_iso {
    iso_url          = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso"
    iso_checksum     = "sha512:0921d8b297c63ac458d8a06f87cd4c353f751eb5fe30fd0d839ca09c0833d1d9934b02ee14bbd0c0ec4f8917dde793957801ae1af3c8122cdf28dde8f3c3e0da"
    iso_storage_pool = "local"
    unmount          = true
  }
  
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  
  node          = "proxmox2"
  password      = "${var.proxmox_password}"
  proxmox_url   = "${var.proxmox_url}"
  ssh_password  = "packer"
  ssh_username  = "packer"
  ssh_timeout   = "15m"
  
  template_description = "Gitlab"
  template_name        = "gitlab"
  username             = "${var.proxmox_username}"
  
  memory       = 4096
  cores        = 2
  cpu_type     = "host"
}

build {
  sources = ["sources.proxmox-iso.gitlab"]
  
  // Ansible provisioner to update and install packages including GitLab
  provisioner "ansible" {
    playbook_file = "../ansible/playbooks/gitlab.yaml"

    ansible_env_vars = [
      "ANSIBLE_ROLES_PATH=../ansible/roles"
    ]
    groups = ["group_gitlab"]
    user = "packer"
    inventory_directory = "../ansible"
  }
}
