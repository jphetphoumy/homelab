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
      tags         = ["kubernetes", "linux", "docker"]
      cpu          = 1
      memory       = 2048 
      disk_size    = 50
      username     = "jphetphoumy"
    }
  }

  containers = {
    samba = {
      vm_id        = 501
      datastore_id = "data"
      ipv4_address = "192.168.1.5/24"
      ipv4_gateway = "192.168.1.1"
      tags         = ["samba", "linux", "lxc"]
      cpu          = 1
      memory       = 512
      disk_size    = 1000
      mount_points = [
        {
          volume = "/media/Disk2"
          path   = "/mnt/backup"
        }
      ]
    }
  }

  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
}
