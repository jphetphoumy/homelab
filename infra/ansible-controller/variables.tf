variable "proxmox_api_url" {
  type    = string
  default = "http://192.168.1.212/api2/json"
}

variable "proxmox_token_id" {
  type    = string
  default = "packer@pve!packer_token"
}

variable "proxmox_token_secret" {
  type    = string
  default = ""
}
