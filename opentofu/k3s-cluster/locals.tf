locals {
  template_file_id = {
    debian12 = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  virtual_machines = {
    "k3s-server" = {
      vm_id        = 601
      datastore_id = "data"
      ipv4_address = "192.168.1.20/24"
      ipv4_gateway = "192.168.1.1"
      tags         = ["kubernetes", "linux", "docker", "k3s_server"]
      cpu          = 2
      memory       = 4096 
      disk_size    = 50
      username     = "jphetphoumy"
    }
    "k3s-node-1" = {
      vm_id        = 602
      datastore_id = "data"
      ipv4_address = "192.168.1.31/24"
      ipv4_gateway = "192.168.1.1"
      tags         = ["kubernetes", "linux", "docker", "k3s_node"]
      cpu          = 1
      memory       = 2048 
      disk_size    = 50
      username     = "jphetphoumy"
    }
    "k3s-node-2" = {
      vm_id        = 603
      datastore_id = "data"
      ipv4_address = "192.168.1.32/24"
      ipv4_gateway = "192.168.1.1"
      tags         = ["kubernetes", "linux", "docker", "k3s_node"]
      cpu          = 1
      memory       = 2048 
      disk_size    = 50
      username     = "jphetphoumy"
    }
  }

  ssh_public_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICNV9Ew6IaAmQ5oiN3gUBAM6qXwKiGBvj/lwt81WJvot jphetphoumy@nixos"
  ]
}
