output "ipv4_address" {
  description = "The public IPv4 address of the server"
  value       = hcloud_server.nixos.ipv4_address
}

output "server_status" {
  description = "The status of the server"
  value       = hcloud_server.nixos.status
}

output "datacenter" {
  description = "The datacenter location of the server"
  value       = hcloud_server.nixos.datacenter
}

output "server_name" {
  description = "The name of the server"
  value       = hcloud_server.nixos.name
}

output "ssh_connection_string" {
  description = "The SSH connection string to connect to the server"
  value       = "ssh root@${hcloud_server.nixos.ipv4_address}"
}
