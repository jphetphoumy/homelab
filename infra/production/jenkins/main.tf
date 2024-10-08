module "runick" {
  source = "../../modules/lxc"

  checksum = "39f6d06e082d6a418438483da4f76092ebd0370a91bad30b82ab6d0f442234d63fe27a15569895e34d6d1e5ca50319f62637f7fb96b98dbde4f6103cf05bff6d"
  checksum_alg = "sha512"
  filename = "debian-12-standard_12.7-1_amd64.tar.zst"
  file_url = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id = "220"
  hostname = "runick"
  ip_address = "192.168.1.220/24"

  tags = ["linux", "cicd", "jenkins-master"]
  additional_ssh_keys = var.additional_ssh_keys
}

module "dogmatika" {
  source = "../../modules/lxc"

  checksum = "39f6d06e082d6a418438483da4f76092ebd0370a91bad30b82ab6d0f442234d63fe27a15569895e34d6d1e5ca50319f62637f7fb96b98dbde4f6103cf05bff6d"
  checksum_alg = "sha512"
  filename = "debian-12-standard_12.7-1_amd64.tar.zst"
  file_url = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"

  vm_id = "221"
  hostname = "dogmatika"
  ip_address = "192.168.1.221/24"

  tags = ["linux", "cicd", "jenkins-agent"]
  additional_ssh_keys = var.additional_ssh_keys
}
