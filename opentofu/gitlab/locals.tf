locals {
  groups = {
    devops = {
      path = "devops"
      description = "All project related to devops"
    }
    hacking = {
      path = "hacking"
      description = "All project related to hacking, malware, zero day"
    }
  }

  mirrors = {
    homelab = {
      group = "devops"
    }
    flux-lab = {
      group = "devops"
    }
  }
}
