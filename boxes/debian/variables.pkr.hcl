variable "proxmox_url" {
  type = string
}

variable "proxmox_token" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "http_port" {
    type = number
    default = 8336
}

variable "http_ip" {
    type = string 
}
