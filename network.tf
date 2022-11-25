# Add network
resource "openstack_networking_network_v2" "terraform" {
  name = "terraform-network"
  admin_state_up = "true"
}

# Add router
resource "openstack_networking_router_v2" "terraform" {
  name = "terraform-router"
  admin_state_up = true
  external_network_id = var.public_network_id
}


# Add subnet
resource "openstack_networking_subnet_v2" "terraform-subnet" {
  name = "terraform-subnet"
  network_id = openstack_networking_network_v2.terraform.id
  cidr = var.subnetwork_cidr
  dns_nameservers = ["194.47.110.95", "194.47.110.96"]
  ip_version = 4
}

# Configure router
resource "openstack_networking_router_interface_v2" "terraform-subnet" {
  router_id = openstack_networking_router_v2.terraform.id
  subnet_id = openstack_networking_subnet_v2.terraform-subnet.id
}

resource "openstack_compute_secgroup_v2" "terraform-secgroup" {
  name = "terraform-secgroup"
  description = "Security group for terraform"

  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port = 8081
    to_port = 8081
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
}