resource "gitlab_project" "this" {
  name = var.repository 
  namespace_id = var.namespace_id 
  import_url = "https://github.com/jphetphoumy/${var.repository}"
}

resource "gitlab_project_mirror" "this" {
  project = gitlab_project.this.id
  url = "ssh://git@github.com/jphetphoumy/${var.repository}.git"
  auth_method = "ssh_public_key"
  keep_divergent_refs = false
  only_protected_branches = false
}

data "gitlab_project_mirror_public_key" "this" {
  project_id = gitlab_project.this.id
  mirror_id  = gitlab_project_mirror.this.mirror_id
}

output "ssh_pub_key" {
  value = data.gitlab_project_mirror_public_key.this.public_key
}

output "ssh" {
  value = data.gitlab_project_mirror_public_key.this
}

resource "github_repository_deploy_key" "this" {
  title = "Gitlab deploy key - Mirror Synchro"
  repository = var.repository 
  key = data.gitlab_project_mirror_public_key.this.public_key
  read_only = false
}
