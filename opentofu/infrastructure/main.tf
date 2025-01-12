locals {
  template_file_id = {
    debian12 = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  containers = {
    samba = {
      tier         = "small"
      vm_id        = 501
      ipv4_address = "192.168.1.5/24"
      ipv4_gateway = "192.168.1.1"
    }
  }

  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
}

module "lxc" {
  source = "../modules/proxmox/lxc"

  for_each = local.containers
  #template_file_id = module.lxc_image.template_file_id
  template_file_id = local.template_file_id.debian12
  node_name        = var.proxmox_node_name

  hostname        = each.key
  vm_id           = each.value.vm_id
  tier            = each.value.tier
  ipv4_address    = each.value.ipv4_address
  ipv4_gateway    = each.value.ipv4_gateway
  ssh_public_keys = local.ssh_public_keys
}
