module "virtual_machine" {
  source = "../../modules/proxmox/virtual_machine"

  node_name = "proxmox2"
  file_id   = "local:iso/debian-12-generic-amd64.img"

  hostname     = "k3s-master"
  vm_id        = 511
  full_clone   = true
  ipv4_address = "192.168.1.20/24"
  ipv4_gateway = "192.168.1.1"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
  tags      = ["k3s", "k3s_master", "virtual_machine", "linux"]
  username  = "jphetphoumy"
  memory    = 4096
  cpu       = 2
  disk_size = 50
}
