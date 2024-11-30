variable "hcloud_server_type" {
  type        = string
  description = "Hetzner Cloud server type"
  default     = "cpx11"
}

variable "hcloud_location" {
  type        = string
  description = "Hetzner Cloud datacenter location"
  default     = "fsn1"
}

variable "target_user" {
  type        = string
  description = "SSH user"
  default     = "root"
}

variable "hetznerApiKey" {
  sensitive   = true
  type        = string
  description = "Hetzner Cloud API Token"
}

variable "sshKeys" {
  type        = string
  sensitive   = true
  description = "SSH public key for server access"
}

variable "ssh_key_password" {
  type        = string
  sensitive   = true
  description = "Password for the SSH private key"
}