resource "forgejo_repository" "homelab" {
  name            = "Homelab"
  clone_addr      = "https://github.com/jphetphoumy/homelab"
  mirror          = true
  mirror_interval = "12h0m0s"
}
