variable "vm_name" {
  type = string
}

variable "vm_ip_addr" {
  type = string
}

variable "vm_gateway" {
  type = string
  default = "192.168.1.1"
}

variable "vm_user" {
  type = string
}

variable "vm_disk_size" {
  type = number
  default = 8
}

variable "ssh_public_key" {
  type = string
}

variable "vm_memory" {
  type = number
  default = 2048
}
