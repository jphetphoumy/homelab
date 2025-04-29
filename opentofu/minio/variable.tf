variable "proxmox_node_name" {
  type = string
}

variable "proxmox_endpoint" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "minio_root_user" {
  type = string
}

variable "minio_root_password" {
  type      = string
  sensitive = true
}
