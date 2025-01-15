locals {
  template_file_id = {
    debian12 = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  containers = {
    samba = {
      vm_id        = 505
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
