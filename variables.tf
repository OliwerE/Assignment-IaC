#Some variables 

variable "subnetwork_cidr" {
  type    = string
  default = "192.168.4.0/24"
}

variable "key_name" {
  type    = string
  default = "Please export an environment variable called TF_VAR_key_name with the name of the key that Terraform should use to build the server among the keys you have in cscloud."
}

variable "identity_file" {
  type    = string
  default = "Please export an environment variable TF_VAR_identity_file with the path to your key for ansible machine. This enables the ansible part to work."
}  

variable "flavor_id" {
  type    = string
  default = "c1-r1-d10"
}

variable "user_name" {
  type    = string
  default = "Username"
}

variable "tenant_name" {
  type    = string
  default = "Tenant name"
}

variable "password" {
  type    = string
  default = "Password"
}

variable "public_network_id" { # not required not same as other users??
  type    = string
  default = "fd401e50-9484-4883-9672-a2814089528c"
}