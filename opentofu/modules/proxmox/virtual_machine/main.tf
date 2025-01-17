resource "proxmox_virtual_environment_vm" "this" {
  name        = var.hostname 
  description = "Managed by Terraform"
  tags        = var.tags 

  node_name = var.node_name 
  vm_id     = var.vm_id 

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = false
  }
  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true

  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  cpu {
    cores        = var.cpu 
    type         = "x86-64-v2-AES"  # recommended for modern CPUs
  }

  memory {
    dedicated = var.memory 
    floating  = var.memory
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = var.file_id 
    interface    = "scsi0"
    size = var.disk_size
  }

  //disk {
  //  datastore_id = "data"
  //  file_format = "raw"
  //  interface = "scsi1"
  //  size = var.disk_size
  //}

  initialization {
    ip_config {
      ipv4 {
        address = var.ipv4_address
        gateway = var.ipv4_gateway
      }
    }

    user_account {
      keys     = var.ssh_public_keys 
      password = "rootme" 
      username = var.username 
    }

    #user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  tpm_state {
    version = "v2.0"
  }

  serial_device {}
}

