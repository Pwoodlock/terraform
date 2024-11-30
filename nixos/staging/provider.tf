terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

provider "hcloud" {
  token = var.hetznerApiKey
}

#
#
#       Adding in Conjur section for secrets
#
#
provider "conjur" {
  appliance_url = "https://your-conjur-instance"
  account       = "your-account"
  login        = "host/terraform-host"
  api_key      = file("path/to/api-key-file")
}

data "conjur_secret" "hetzner_api_key" {
  name = "hetzner/api-key"
}

data "conjur_secret" "ssh_public_key" {
  name = "ssh/public-key"
}

