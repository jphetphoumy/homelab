resource "proxmox_virtual_environment_download_file" "this" {
  content_type = "iso"
  datastore_id = var.datastore_id
  node_name    = var.node_name
  url          = var.image_url
  file_name    = "debian-12-generic-amd64.img"
}
