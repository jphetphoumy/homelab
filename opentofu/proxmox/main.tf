locals {
  pools = [
    "production-pool",
    "lab-pool"
  ]
}

resource "proxmox_virtual_environment_pool" "production" {
  for_each = toset(local.pools)
  comment = "Managed by opentofu"
  pool_id = each.key 
}
