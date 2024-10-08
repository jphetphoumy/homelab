variable "filename" {
  type = string
}

variable "checksum" {
  type = string
}

variable "checksum_alg" {
  type    = string
  default = "sha512"
}

variable "file_url" {
  type = string
}

variable "hostname" {
  type = string
}

variable "ip_address" {
  type = string
}

variable "ip_gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "tags" {
    type = list(string)
}

variable "vm_id" {
    type = string
}

variable "lxc_memory" {
  type = number
  default = 2048
}

variable "ssh_private_key" {
  type = string
  default = "~/.ssh/id_ed25519"
}

variable "additional_ssh_keys" {
  type = list(string)
  default = []
}
