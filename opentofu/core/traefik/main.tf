module "traefik" {
  source = "../../modules/proxmox/lxc/"

  template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id     = 507
  node_name = "proxmox2"

  tags = ["linux", "traefik", "reverse_proxy", "lxc"]

  hostname = "traefik"
  # Networking
  ipv4_gateway = "192.168.1.1"
  ipv4_address = "192.168.1.7/24"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
  dns_servers = ["192.168.1.8"]
  mount_points = [
    {
      volume = "/media/Disk2/traefik"
      path   = "/opt/traefik"
    }
  ]
}

resource "null_resource" "wait_for" {
  depends_on = [module.traefik]

  connection {
    host        = "192.168.1.7"
    private_key = file("/home/jphetphoumy/.ssh/id_ed25519")
  }

  provisioner "remote-exec" {
    inline = ["echo 'connected'"]
  }
}

resource "null_resource" "ansible" {
  depends_on = [null_resource.wait_for]

  provisioner "local-exec" {
    command = "source ../../../.env && cd ../../../ansible && ansible-playbook -i inventory.proxmox.yml playbooks/traefik.yml -uroot"
  }
}
