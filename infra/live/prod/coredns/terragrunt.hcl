include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "env" {
  path = "${get_terragrunt_dir()}/env.hcl"
  expose = true
}

terraform {
  source = "../../../catalog/modules/proxmox/lxc"

  after_hook "after_hook" {
    commands = ["apply"]
    execute = ["sh", "-c", "ANSIBLE_CONFIG=${get_repo_root()}/ansible/ansible.cfg ansible-playbook -i ${get_repo_root()}/ansible/inventory.proxmox.yml ${get_repo_root()}/ansible/playbooks/${include.env.locals.playbook}"]
    run_on_error = false
  }
}

inputs = {
  vm_id     = 508
  node_name = "proxmox2"

  tags = ["linux", "dns", "coredns", "lxc"]

  hostname = "coredns"
  # Networking
  ipv4_gateway = "192.168.1.1"
  ipv4_address = "192.168.1.8/24"
  ssh_public_keys = [
    file("/home/jphetphoumy/.ssh/id_ed25519.pub")
  ]
  dns_servers = ["192.168.1.1"]
}
