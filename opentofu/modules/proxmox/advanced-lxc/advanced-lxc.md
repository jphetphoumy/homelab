## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.73.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.73.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait_for](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [proxmox_virtual_environment_container.this](https://registry.terraform.io/providers/bpg/proxmox/0.73.0/docs/resources/virtual_environment_container) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_playbook"></a> [ansible\_playbook](#input\_ansible\_playbook) | n/a | `string` | n/a | yes |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `1` | no |
| <a name="input_datastore_id"></a> [datastore\_id](#input\_datastore\_id) | n/a | `string` | `"local-lvm"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | n/a | `number` | `4` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | n/a | `string` | n/a | yes |
| <a name="input_ipv4_address"></a> [ipv4\_address](#input\_ipv4\_address) | n/a | `string` | n/a | yes |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | n/a | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `512` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | n/a | <pre>list(object({<br/>    volume = string<br/>    path   = string<br/>  }))</pre> | `[]` | no |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | n/a | <pre>list(object({<br/>    name = string<br/>    bridge = string<br/>    firewall = bool<br/>    vlan_id = number<br/>  }))</pre> | <pre>[<br/>  {<br/>    "bridge": "vmbr0",<br/>    "firewall": true,<br/>    "name": "eth0",<br/>    "vlan_id": null<br/>  }<br/>]</pre> | no |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | n/a | `string` | n/a | yes |
| <a name="input_ssh_public_keys"></a> [ssh\_public\_keys](#input\_ssh\_public\_keys) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_template_file_id"></a> [template\_file\_id](#input\_template\_file\_id) | n/a | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | n/a | `string` | `"small"` | no |
| <a name="input_tiers"></a> [tiers](#input\_tiers) | Settings for container tiers | <pre>map(object({<br/>    cpu    = number<br/>    memory = number<br/>    disk   = number<br/>  }))</pre> | <pre>{<br/>  "large": {<br/>    "cpu": 4,<br/>    "disk": 20,<br/>    "memory": 2048<br/>  },<br/>  "medium": {<br/>    "cpu": 2,<br/>    "disk": 10,<br/>    "memory": 1024<br/>  },<br/>  "small": {<br/>    "cpu": 1,<br/>    "disk": 5,<br/>    "memory": 512<br/>  }<br/>}</pre> | no |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | n/a | `number` | `100` | no |

## Outputs

No outputs.
