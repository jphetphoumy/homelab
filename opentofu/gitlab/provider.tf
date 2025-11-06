provider "gitlab" {
  token    = var.gitlab_token
  base_url = var.gitlab_url
}

provider "github" {
  token = var.github_token
}
