module "lxc" {
  source = "../modules/proxmox/lxc"

  template_file_id = local.template_file_id.debian12
  node_name        = var.proxmox_node_name
  datastore_id     = "data"

  hostname        = "minio"
  vm_id           = "600"
  ipv4_address    = "192.168.1.50/24"
  ipv4_gateway    = "192.168.1.1"
  ssh_public_keys = local.ssh_public_keys
  tags            = ["minio", "linux", "lxc"]
  mount_points    = []
  network_interfaces = [{
    name     = "eth0"
    bridge   = "vmbr0"
    firewall = null
    vlan_id  = null
  }]
  cpu       = 2
  memory    = 2048
  disk_size = 50
}

data "template_file" "minio_env" {
  template = "${file("${path.module}/minio_env.tftpl")}"

  vars = {
    minio_root_password = var.minio_root_password
    minio_root_user = var.minio_root_user
  }
}

resource "null_resource" "minio-init" {
  connection {
    host        = "192.168.1.50"
    private_key = file("/home/jphetphoumy/.ssh/id_ed25519")
  }

  provisioner "file" {
    content = data.template_file.minio_env.rendered
    destination = "/etc/default/minio"
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
      "wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20250422221226.0.0_amd64.deb -O minio.deb",
      "dpkg -i minio.deb",
      "groupadd -r minio-user",
      "useradd -M -r -g minio-user minio-user",
      "mkdir /mnt/data",
      "chown minio-user:minio-user /mnt/data",
      "chown root:root /etc/default/minio",
      "chmod 644 /etc/default/minio",
      "systemctl start minio",
    ]
  }
}
