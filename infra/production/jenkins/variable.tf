variable "proxmox_password" {
  type = string
  sensitive = true
}

variable "additional_ssh_keys" {
  type = list(string)
  default = []
}
