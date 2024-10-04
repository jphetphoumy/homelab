module "virtual-machine" {
  source       = "../../modules/virtual_machine"
  filename     = "openmediavault_${var.omv_version}-32-amd64.iso"
  checksum     = "8587c71ce8845b1ff501e6c33b9ee033345f95b8328ea91129f82d686dc9d7e5"
  checksum_alg = "sha256"
  file_url     = "https://sourceforge.net/projects/openmediavault/files/iso/${var.omv_version}/openmediavault_${var.omv_version}-amd64.iso"

  vm_name      = "omv-server"
  vm_ip_addr   = "192.168.1.100/24"
  vm_gateway   = "192.168.1.1"
  vm_user      = "jphetphoumy"
  vm_disk_size = 20
  ssh_public_key = "/home/jphetphoumy/.ssh/id_ed25519.pub"
}
