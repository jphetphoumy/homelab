variable "template_file_id" {
  type = string
}

variable "ssh_public_keys" {
  type = list(string)
}

variable "node_name" {
  type = string
}

variable "datastore_id" {
  type = string
  default = "local-lvm"
}

variable "hostname" {
  type = string
}

variable "vm_id" {
  type = number
  default = 100
}

variable "ipv4_address" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "tier" {
  type = string
  default = "small"
}

variable "tiers" {
  description = "Settings for container tiers"
  type = map(object({
    cpu = number
    memory = number
    disk = number 
  }))
  default = {
    small = {
      cpu = 1
      memory = 512
      disk = 5
    }
    medium = {
      cpu = 2
      memory = 1024 
      disk = 10 
    }
    large = {
      cpu = 4
      memory = 2048 
      disk = 20 
    }
  }
}
