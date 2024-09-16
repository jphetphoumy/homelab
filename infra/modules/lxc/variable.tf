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
