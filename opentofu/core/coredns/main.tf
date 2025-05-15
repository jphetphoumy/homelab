module "coredns" {
  source = "../../modules/proxmox/lxc/"

  template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id     = 508
  node_name = "proxmox2"

  tags = ["linux", "dns", "coredns", "lxc"]

  hostname = "coredns"
  # Networking
  ipv4_gateway = "192.168.1.1"
  ipv4_address = "192.168.1.8/24"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
}

resource "null_resource" "wait_for" {
  depends_on = [module.coredns]

  connection {
    host = "192.168.1.8"
    private_key = file("/home/jphetphoumy/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = ["echo 'connected'"]
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.wait_for]

  provisioner "local-exec" {
    command = "source ../../../.env && cd ../../../ansible && ansible-playbook -i inventory.proxmox.yml playbooks/coredns.yaml -uroot"
  }
}
