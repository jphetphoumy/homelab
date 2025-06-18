module "virtual_machine" {
  source = "../../modules/proxmox/virtual_machine"

  node_name = "proxmox2"
  file_id   = "local:iso/debian-12-generic-amd64.img"

  hostname     = "gitlab"
  vm_id        = 506
  clone_id     = 100
  full_clone   = true
  ipv4_address = "192.168.1.6/24"
  ipv4_gateway = "192.168.1.1"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
  tags      = ["gitlab", "virtual_machine", "linux"]
  username  = "jphetphoumy"
  memory    = 8192
  cpu       = 2
  disk_size = 50
}

resource "null_resource" "wait_for" {
  depends_on = [module.virtual_machine]

  connection {
    host        = "192.168.1.6"
    user        = "jphetphoumy"
    private_key = file("/home/jphetphoumy/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = ["echo 'connected'"]
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.wait_for]

  provisioner "local-exec" {
    command = "source ../../../.env && cd ../../../ansible && ansible-playbook -i inventory.proxmox.yml playbooks/gitlab.yaml --become"
  }
}

resource "null_resource" "gitlab_app_config" {
  depends_on = [null_resource.ansible]

  provisioner "local-exec" {
    command = "source ../../../.env && cd ../../../ansible && ansible-playbook -i inventory.proxmox.yml playbooks/gitlab_app_config.yaml --become"
  }
}
