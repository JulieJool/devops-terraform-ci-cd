# terr-setup/backend.tf
terraform {
  backend "remote" {
    organization = "JulieJool"
    workspaces {
      name = "terr-setup"
    }
  }
}
