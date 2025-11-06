resource "gitlab_group" "this" {
  for_each = local.groups
  name = each.key
  path = each.value.path
  description = each.value.description
}

module "mirror" {
  source = "./modules/github-to-gitlab"

  for_each = local.mirrors
  repository = each.key
  namespace_id = gitlab_group.this[each.value.group].id
}

resource "gitlab_user" "jphetphoumy" {
  name = "Jérémy Phetphoumy"
  username = "jphetphoumy"
  password = var.gitlab_password
  email = "jphetphoumy@gmail.com"
  is_admin = true
  can_create_group = true
  is_external = true
  reset_password = false
}

resource "gitlab_group_membership" "this" {
  for_each = local.groups
  group_id = gitlab_group.this[each.key].id
  user_id = gitlab_user.jphetphoumy.id
  access_level = "owner"
}

resource "gitlab_user_sshkey" "nixos" {
  user_id = gitlab_user.jphetphoumy.id
  title = "nixos-wsl"
  key = file("/home/jphetphoumy/.ssh/jphetphoumy_key.pub")
}
