locals {
  template_file_id = {
    debian12 = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  ssh_public_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICNV9Ew6IaAmQ5oiN3gUBAM6qXwKiGBvj/lwt81WJvot jphetphoumy@nixos",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnwnvhIGKYA9H43mwhHMewDYqqzXHLbPZvcGNyj7rw+yvjeamkU+ud+i1IvQCnRoEvw5tXMh9MjOxhErOUDcLVxja3j3pWJLg2eS1LzZQLFy317o7Asq5gfGe7K5SW5o8VNWypIfCO4wMX15LhM7ksJInTq0Ylh9+vUtK81kgM9wxoKqPJKMmct+hDAXsKaBTMYHuA1NhecSVfE6icNnLEzkEx85iQVJGRt9TN0dm2eDXHpSXJAm23qeTXOzdVnWZZg49rClgf65jMMSxTehFo849H/aJrI/28F8bVocPuf+WN3uVQaHAXC9sHcOvBEZnr5le4LuiEYitsFk55qe5Rp/lrIMq8L6wlnm4BwPwawBl6/+eAdbKiVHFro0x1Jdr4h0qr4B1Zcd6usUT6YDvQX3XOlWEDU2I5HfQk8AkTHUT84PMH2ZgxCIfuwmrCpxkfCmYFb30hSfVS+MilPnQfjGxvBue5TyJlV7razPQundi/oDXCy9pFhRorsdTpcCU= jphet@Workstatation"
  ]
}
