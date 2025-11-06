terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "17.11.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
}
