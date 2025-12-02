resource "proxmox_virtual_environment_download_file" "this" {
  content_type = "vztmpl"
  datastore_id = var.datastore_id
  node_name    = var.node_name
  url          = var.image_url
}
