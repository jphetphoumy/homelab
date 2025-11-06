## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.6.0 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | 17.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.6.0 |
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 17.11.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/6.6.0/docs/resources/repository_deploy_key) | resource |
| [gitlab_project.this](https://registry.terraform.io/providers/gitlabhq/gitlab/17.11.0/docs/resources/project) | resource |
| [gitlab_project_mirror.this](https://registry.terraform.io/providers/gitlabhq/gitlab/17.11.0/docs/resources/project_mirror) | resource |
| [gitlab_project_mirror_public_key.this](https://registry.terraform.io/providers/gitlabhq/gitlab/17.11.0/docs/data-sources/project_mirror_public_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | n/a | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ssh"></a> [ssh](#output\_ssh) | n/a |
| <a name="output_ssh_pub_key"></a> [ssh\_pub\_key](#output\_ssh\_pub\_key) | n/a |
