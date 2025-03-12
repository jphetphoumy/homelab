module "lxc" {
  source = "../modules/proxmox/lxc"

  for_each         = local.containers
  template_file_id = local.template_file_id.debian12
  node_name        = var.proxmox_node_name
  datastore_id     = each.value.datastore_id

  hostname           = each.key
  vm_id              = each.value.vm_id
  ipv4_address       = each.value.ipv4_address
  ipv4_gateway       = each.value.ipv4_gateway
  ssh_public_keys    = local.ssh_public_keys
  tags               = each.value.tags
  mount_points       = each.value.mount_points
  network_interfaces = each.value.network_interfaces
  cpu                = each.value.cpu
  memory             = each.value.memory
  disk_size          = each.value.disk_size
}
