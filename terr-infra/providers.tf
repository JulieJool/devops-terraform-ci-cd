terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"

data "terraform_remote_state" "setup" {
  backend = "remote"

  config = {
    organization = "JulieJool"
    workspaces = {
      name = "terr-setup"
    }
  }
}

provider "yandex" {
  service_account_key_file = jsonencode({
    id                  = data.terraform_remote_state.setup.outputs.service_account_key_id
    service_account_id  = data.terraform_remote_state.setup.outputs.service_account_id
    private_key         = data.terraform_remote_state.setup.outputs.private_key
  })
  cloud_id    = var.cloud_id
  folder_id   = var.folder_id
  zone        = var.default_zone
}
