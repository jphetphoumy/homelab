module "lxc" {
  source = "../../modules/lxc"

  checksum = "39f6d06e082d6a418438483da4f76092ebd0370a91bad30b82ab6d0f442234d63fe27a15569895e34d6d1e5ca50319f62637f7fb96b98dbde4f6103cf05bff6d"
  checksum_alg = "sha512"
  filename = "debian-12-standard_12.7-1_amd64.tar.zst"
  file_url = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id = "230"
  hostname = "tearlaments"
  ip_address = "192.168.1.230/24"

  tags = ["linux", "traefik", "reverse-proxy"]
}