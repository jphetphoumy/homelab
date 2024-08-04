terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc2"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
}

resource "proxmox_vm_qemu" "jenkins" {
  name        = "jenkins"
  target_node = "proxmox"

  memory = 4096

  network {
    bridge = "vmbr0"
    model  = "e1000"
  }

  disks {
    ide {
      ide0 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = "50G"
          storage = "local-lvm"
        }
      }
    }
  }

  agent      = 0
  clone      = "jenkins-baseline"
  full_clone = true
  tags       = "cicd"

  os_type   = "cloud-init"
  ciuser    = "jenkins"
  sshkeys   = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnwnvhIGKYA9H43mwhHMewDYqqzXHLbPZvcGNyj7rw+yvjeamkU+ud+i1IvQCnRoEvw5tXMh9MjOxhErOUDcLVxja3j3pWJLg2eS1LzZQLFy317o7Asq5gfGe7K5SW5o8VNWypIfCO4wMX15LhM7ksJInTq0Ylh9+vUtK81kgM9wxoKqPJKMmct+hDAXsKaBTMYHuA1NhecSVfE6icNnLEzkEx85iQVJGRt9TN0dm2eDXHpSXJAm23qeTXOzdVnWZZg49rClgf65jMMSxTehFo849H/aJrI/28F8bVocPuf+WN3uVQaHAXC9sHcOvBEZnr5le4LuiEYitsFk55qe5Rp/lrIMq8L6wlnm4BwPwawBl6/+eAdbKiVHFro0x1Jdr4h0qr4B1Zcd6usUT6YDvQX3XOlWEDU2I5HfQk8AkTHUT84PMH2ZgxCIfuwmrCpxkfCmYFb30hSfVS+MilPnQfjGxvBue5TyJlV7razPQundi/oDXCy9pFhRorsdTpcCU= jphet@Workstatation
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICNV9Ew6IaAmQ5oiN3gUBAM6qXwKiGBvj/lwt81WJvot jphetphoumy@nixos
  EOF
  ipconfig0 = "ip=192.168.1.110/24,gw=192.168.1.1"

  connection {
    type        = "ssh"
    user        = "jenkins"
    host        = self.default_ipv4_address
    private_key = file("~/.ssh/id_rsa")
  }

  //provisioner "remote-exec" {
  //  inline = [
  //    "pipx install ansible-core",
  //    "pipx ensurepath"
  //  ]
  //}
}
