resource "proxmox_virtual_environment_download_file" "debian_12" {
  content_type       = var.content_type
  datastore_id       = "local"
  file_name          = var.filename
  node_name          = "proxmox"
  url                = var.file_url
  checksum           = var.checksum
  checksum_algorithm = var.checksum_alg
}
