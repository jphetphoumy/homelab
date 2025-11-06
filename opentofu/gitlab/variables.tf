variable "gitlab_token" {
  type = string
}

variable "gitlab_url" {
  type = string
}

variable "github_token" {
  type = string
}

variable "gitlab_password" {
  type      = string
  sensitive = true
}
