# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

# Configure OpenStack provider
provider "openstack" {
  user_name = var.os_username
  tenant_name = var.os_tenant_name
  password = var.os_password
  auth_url = var.os_auth_url
}