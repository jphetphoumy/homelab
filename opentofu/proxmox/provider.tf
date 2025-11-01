provider "proxmox" {
  endpoint = var.proxmox_endpoint 

  username = var.proxmox_username 
  password = var.proxmox_password 

  insecure = true
  # uncomment (unless on Windows...)
  # tmp_dir  = "/var/tmp"

  #ssh {
  #  agent = true
  #  # TODO: uncomment and configure if using api_token instead of password
  #  # username = "root"
  #}
}
