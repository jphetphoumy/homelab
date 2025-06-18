# GitLab Packer Template for Proxmox

This Packer template creates a GitLab server template in Proxmox.

## Prerequisites

- Packer installed on your machine
- Access to a Proxmox server
- Debian 12 ISO uploaded to your Proxmox server

## Configuration

The template is configured to:
- Create a VM with 4GB of RAM and 2 CPU cores
- Create a 20GB SCSI disk
- Use UEFI boot
- Install Debian 12
- Install GitLab Community Edition
- Convert the VM to a template

## Usage

1. Set your Proxmox password as an environment variable:

```bash
export PKR_VAR_proxmox_password="your_proxmox_password"
```

2. Customize the variables in `main.pkr.hcl` as needed

3. Validate the template:

```bash
packer validate main.pkr.hcl
```

4. Build the template:

```bash
packer build main.pkr.hcl
```

## Customization

- Edit `main.pkr.hcl` to change VM specifications
- Edit `config/preseed.cfg` to customize the Debian installation
- Modify the provisioners section to customize the GitLab installation

## Notes

- The default GitLab external URL is set to http://gitlab.example.com. Change this to your actual domain before deployment.
- After creating a VM from this template, you'll need to:
  1. Set a proper hostname and IP configuration
  2. Update the GitLab external URL in `/etc/gitlab/gitlab.rb`
  3. Run `gitlab-ctl reconfigure` to apply changes
