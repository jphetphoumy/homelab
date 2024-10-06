variable "proxmox_password" {
  type = string
  sensitive = true
}

variable "ssh_private_key" {
  type = string
  default = "~/.ssh/id_ed25519"
}
