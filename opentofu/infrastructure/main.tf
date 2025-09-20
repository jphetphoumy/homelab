module "lxc" {
  source = "../modules/proxmox/lxc"

  for_each = {
    for name, cfg in local.containers :
    name => cfg if contains(cfg.tags, "env_${terraform.workspace}") || terraform.workspace == "default"
  }

  template_file_id = local.template_file_id.debian12
  node_name        = var.proxmox_node_name
  datastore_id     = each.value.datastore_id

  hostname           = each.key
  dns_servers        = each.value.dns_servers
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

module "vm_image" {
  source = "../modules/proxmox/vm_image"

  node_name = var.proxmox_node_name
  image_url = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-generic-amd64.qcow2"
}

module "virtual_machine" {
  source = "../modules/proxmox/virtual_machine"

  for_each = {
    for name, cfg in local.virtual_machines :
    name => cfg if contains(cfg.tags, "env_${terraform.workspace}") || terraform.workspace == "default"
  }

  node_name = var.proxmox_node_name
  file_id   = module.vm_image.file_id

  hostname           = each.key
  vm_id              = each.value.vm_id
  ipv4_address       = each.value.ipv4_address
  ipv4_gateway       = each.value.ipv4_gateway
  ssh_public_keys    = local.ssh_public_keys
  tags               = each.value.tags
  network_interfaces = each.value.network_interfaces
  cpu                = each.value.cpu
  memory             = each.value.memory
  disk_size          = each.value.disk_size
  username           = each.value.username
}
