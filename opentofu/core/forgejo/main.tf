module "forgejo" {
  source = "../../modules/proxmox/advanced-lxc/"

  template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id     = 509
  node_name = "proxmox2"

  tags = ["linux", "git", "forgejo", "lxc"]

  hostname = "forgejo"
  # Networking
  ipv4_gateway = "192.168.1.1"
  ipv4_address = "192.168.1.9/24"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
  ansible_playbook = "forgejo.yaml"
}
