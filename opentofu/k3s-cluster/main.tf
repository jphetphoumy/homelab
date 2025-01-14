module "vm_image" {
  source = "../modules/proxmox/vm_image"

  node_name = var.proxmox_node_name
  image_url = "https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
}

module "virtual_machine" {
  source = "../modules/proxmox/virtual_machine"

  for_each     = local.virtual_machines
  file_id      = module.vm_image.file_id
  node_name    = var.proxmox_node_name
  datastore_id = each.value.datastore_id

  hostname        = each.key
  vm_id           = each.value.vm_id
  ipv4_address    = each.value.ipv4_address
  ipv4_gateway    = each.value.ipv4_gateway
  ssh_public_keys = local.ssh_public_keys
  tags            = each.value.tags
  cpu             = each.value.cpu
  memory          = each.value.memory
  disk_size       = each.value.disk_size
  username        = each.value.username
}
