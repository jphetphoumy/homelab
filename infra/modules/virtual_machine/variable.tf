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

variable "content_type" {
  type    = string
  default = "iso"
}
