terraform {
  required_providers {
    forgejo = {
      source = "svalabs/forgejo"
      version = "0.3.0"
    }
  }
}

provider "forgejo" {
  host = "https://forgejo.hackandpwned.fr"
  username = "jphetphoumy"
  password = var.forgejo_password
}
