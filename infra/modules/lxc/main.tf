resource "proxmox_virtual_environment_download_file" "lxc_template" {
  content_type       = "vztmpl"
  datastore_id       = "local"
  file_name          = var.filename
  node_name          = "proxmox"
  url                = var.file_url
  checksum           = var.checksum
  checksum_algorithm = var.checksum_alg
}

resource "proxmox_virtual_environment_container" "lxc" {
  description = "Managed by opentofu"

  unprivileged = true
  tags = var.tags

  node_name = "proxmox"
  vm_id     = var.vm_id

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.ip_gateway
      }
    }

    user_account {
      password = random_password.lxc_password.result
      keys = [
        trimspace(data.tls_public_key.private_key_openssh.public_key_openssh)
      ]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = true
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.lxc_template.id
    type             = "debian"
  }

  memory {
    dedicated = var.lxc_memory
  }

  features {
    nesting = true
  }
}

data "tls_public_key" "private_key_openssh" {
  private_key_openssh = file("~/.ssh/id_ed25519")
}

resource "random_password" "lxc_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}
