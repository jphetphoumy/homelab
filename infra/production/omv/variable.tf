variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "omv_version" {
  type    = string
  default = "7.0-32"
}
