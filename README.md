# Homelab

This repository contains all my infrastructure code for my homelab.

My homelab contains a Proxmox server and a cluster of raspberry Pi 3

## Repository structure

```
├── boxes
│   ├── debian
│   └── nixos
├── infra
│   └── ansible-controller
└── provisioning
    ├── proxmox
    └── raspberry
```

## Directories
- **boxes**: Contains the Packer templates for QEMU VMs.
    - **debian**: Templates for Debian VMs.
    - **nixos**: Templates for NixOS VMs.
- **infra**: Contains the Terraform code to deploy specific VMs or LXC containers inside the Proxmox lab.
    - **ansible-controller**: Terraform configurations for the Ansible controller.
- **provisioning**: Contains all the Ansible playbooks and roles.
    - **proxmox**: Ansible role for provisioning Proxmox resources.
    - **raspberry**: Ansible role for provisioning Raspberry Pi resources.

- **boxes** contains the packer template for qemu VM.
- **infra** contains the terraform code to deploy specific VM or LXC containers inside my proxmox lab
- **provisioning** contains all the ansible playbook and role

# Usage
1. **Packer**: Use the templates in the boxes directory to create VMs.
2. **Terraform**: Use the configurations in the infra directory to deploy VMs or LXC containers.
3. **Ansible**: Use the playbooks in the provisioning directory to provision and configure your homelab infrastructure.

# Getting Started
## Prerequesites
- Promox
- Packer
- Terraform
- Ansible

## Steps

1. Clone the repository
```bash
git clone https://github.com/yourusername/homelab.git
cd homelab
```

2. Build VM Images with Packer
```bash
cd boxes/debian
packer build .
```

3. Deploy infrastructure with Terraform

```bash
cd infra/ansible-controller
terraform init
terraform plan 
terraform apply
```

4. Provision and configure with ansible

```bash
cd provisioning/proxmox
ansible-playbook manage_proxmox.yaml
```