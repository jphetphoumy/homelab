data "local_file" "ssh_public_key" {
  filename = var.ssh_public_key
}

resource "proxmox_virtual_environment_vm" "proxmox_vm" {
  name      = var.vm_name
  node_name = "proxmox"

  clone {
    vm_id = 100
  }

  initialization {

    ip_config {
      ipv4 {
        address = var.vm_ip_addr
        gateway = var.vm_gateway
      }
    }

    user_account {
      username = var.vm_user
      keys     = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  disk {
    datastore_id = "local-lvm"
    size         = var.vm_disk_size
    interface = "virtio0"
    file_format = "raw"
  }

  network_device {
    bridge = "vmbr0"
  }

  memory {
    dedicated = var.vm_memory
  }
}

