locals {
    secret_vars = yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.yaml")))
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "proxmox" {
  endpoint = "${local.secret_vars.proxmox_endpoint}"

  username = "${local.secret_vars.proxmox_username}"
  password = "${local.secret_vars.proxmox_password}"

  insecure = true
  tmp_dir  = "/var/tmp"

  ssh {
    agent = true
    # username = "root"
  }
}
EOF
}

inputs = {
  template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
}
