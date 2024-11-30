
data "hcloud_ssh_key" "nixos" {
  name = "nixos-dd@nixos"
}

resource "hcloud_server" "nixos" {
  name        = "nixos-server"
  server_type = "cpx11"
  location    = var.hcloud_location
  image       = "debian-12"
  ssh_keys    = [data.hcloud_ssh_key.nixos.id]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
}

module "deploy" {
  source = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  
  nixos_system_attr = ".#nixosConfigurations.hetzner-cloud.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.hetzner-cloud.config.system.build.disko"
  target_host = hcloud_server.nixos.ipv4_address
  instance_id = hcloud_server.nixos.id
  debug_logging = true

  extra_files_script = <<-EOT
    #!/usr/bin/env bash
    set -euo pipefail
    
    mkdir -p etc/ssh/authorized_keys.d
    printf "%s" "${var.sshKeys}" > etc/ssh/authorized_keys.d/root
    printf "%s" "${var.sshKeys}" > etc/ssh/authorized_keys.d/patrick
    chmod 755 etc/ssh/authorized_keys.d
    chmod 600 etc/ssh/authorized_keys.d/root
    chmod 600 etc/ssh/authorized_keys.d/patrick
  EOT

  depends_on = [hcloud_server.nixos]
}