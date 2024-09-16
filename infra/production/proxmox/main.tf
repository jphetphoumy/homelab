variable "lxc_images" {
    type = map(object({
        checksum = string
        checksum_alg = string
        filename = string
        file_url = string
    }))
    default = {
      debian = {
        checksum = "39f6d06e082d6a418438483da4f76092ebd0370a91bad30b82ab6d0f442234d63fe27a15569895e34d6d1e5ca50319f62637f7fb96b98dbde4f6103cf05bff6d"
        checksum_alg = "sha512"
        filename = "debian-12-standard_12.7-1_amd64.tar.zst"
        file_url = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"
      }
    }
}

resource "proxmox_virtual_environment_download_file" "lxc_template" {
  for_each           = var.lxc_images
  content_type       = "vztmpl"
  datastore_id       = "local"
  file_name          = each.value.filename
  node_name          = "proxmox"
  url                = each.value.file_url
  checksum           = each.value.checksum
  checksum_algorithm = each.value.checksum_alg
}
