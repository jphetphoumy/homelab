resource "proxmox_virtual_environment_container" "this" {
  description = "Managed by Opentofu"

  node_name = var.node_name
  vm_id     = var.vm_id

  disk {
    datastore_id = var.datastore_id
    size = var.tiers[var.tier].disk
  }

  memory {
    dedicated = var.tiers[var.tier].memory
  }

  cpu {
    cores = var.tiers[var.tier].cpu
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      keys = var.ssh_public_keys
      password = "rootme"
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = "debian"
  }

  features {
    nesting = true
  }

}
