resource "proxmox_virtual_environment_container" "this" {
  description = "Managed by Opentofu"

  node_name = var.node_name
  vm_id     = var.vm_id

  tags = var.tags

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_size
  }

  memory {
    dedicated = var.memory
  }

  cpu {
    cores = var.cpu
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
      keys     = var.ssh_public_keys
      password = random_password.this.result
    }
  }


  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      name     = network_interface.value.name
      bridge   = network_interface.value.bridge
      firewall = network_interface.value.firewall
      vlan_id = network_interface.value.vlan_id
    }
  }

  operating_system {
    template_file_id = var.template_file_id
    type             = "debian"
  }

  features {
    nesting = true
  }

  dynamic "mount_point" {
    for_each = var.mount_points
    content {
      volume = mount_point.value["volume"]
      path   = mount_point.value["path"]
    }
  }

}

resource "random_password" "this" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "null_resource" "wait_for" {
  depends_on = [proxmox_virtual_environment_container.this]

  connection {
    host = trimsuffix(var.ipv4_address, "/24")
    private_key = file("/home/jphetphoumy/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = ["echo 'connected'"]
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.wait_for]

  provisioner "local-exec" {
    command = "source ../../../.env && cd ../../../ansible && ansible-playbook -i inventory.proxmox.yml playbooks/${var.ansible_playbook} -uroot"
  }
}
