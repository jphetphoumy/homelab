locals {
  template_file_id = {
    debian12 = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  containers = {
    galatea = {
      vm_id        = 505
      datastore_id = "data"
      ipv4_address = "192.168.1.5/24"
      ipv4_gateway = "192.168.1.1"
      tags         = ["nas", "linux", "lxc"]
      cpu          = 1
      memory       = 512
      disk_size    = 20
      network_interfaces = [{
        name     = "eth0"
        bridge   = "vmbr0"
        firewall = true
        vlan_id  = null
      }]
      mount_points = [
        {
          volume = "/media/Disk2"
          path   = "/mnt/backup"
        }
      ]
    }
  }

  ssh_public_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICNV9Ew6IaAmQ5oiN3gUBAM6qXwKiGBvj/lwt81WJvot jphetphoumy@nixos",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnwnvhIGKYA9H43mwhHMewDYqqzXHLbPZvcGNyj7rw+yvjeamkU+ud+i1IvQCnRoEvw5tXMh9MjOxhErOUDcLVxja3j3pWJLg2eS1LzZQLFy317o7Asq5gfGe7K5SW5o8VNWypIfCO4wMX15LhM7ksJInTq0Ylh9+vUtK81kgM9wxoKqPJKMmct+hDAXsKaBTMYHuA1NhecSVfE6icNnLEzkEx85iQVJGRt9TN0dm2eDXHpSXJAm23qeTXOzdVnWZZg49rClgf65jMMSxTehFo849H/aJrI/28F8bVocPuf+WN3uVQaHAXC9sHcOvBEZnr5le4LuiEYitsFk55qe5Rp/lrIMq8L6wlnm4BwPwawBl6/+eAdbKiVHFro0x1Jdr4h0qr4B1Zcd6usUT6YDvQX3XOlWEDU2I5HfQk8AkTHUT84PMH2ZgxCIfuwmrCpxkfCmYFb30hSfVS+MilPnQfjGxvBue5TyJlV7razPQundi/oDXCy9pFhRorsdTpcCU= jphet@Workstatation"
  ]
}
