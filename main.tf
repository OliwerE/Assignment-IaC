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

# Configure the OpenStack Provider
provider "openstack" {
  user_name = var.os_username
  tenant_name = var.os_tenant_name
  password = var.os_password
  auth_url = var.os_auth_url
}

# Add router
resource "openstack_networking_router_v2" "terraform" {
  name = "terraform-router"
  admin_state_up = true
  external_network_id = var.public_network_id
}

# Add network
resource "openstack_networking_network_v2" "terraform" {
  name = "terraform-network"
  admin_state_up = "true"
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

# Create floating ip
resource "openstack_networking_floatingip_v2" "terraform-floatingip" {
  pool = "public"
}

# Add instance
resource "openstack_compute_instance_v2" "terraform-instance" {
  name = "terraform-instance"
  image_id = "ca4bec1a-ac25-434f-b14c-ad8078ccf39f"
  flavor_id = var.flavor_id
  key_pair = var.key_name
  security_groups = ["default", "terraform-secgroup"]
  availability_zone = "Education"

  network {
    name = "terraform-network"
  }

  depends_on = [
    openstack_networking_network_v2.terraform,
    openstack_compute_secgroup_v2.terraform-secgroup,
  ]
}

# Associate floating ip to instance and install nginx
resource "openstack_compute_floatingip_associate_v2" "terraform-floatingip" {
  floating_ip = "${openstack_networking_floatingip_v2.terraform-floatingip.address}"
  instance_id = "${openstack_compute_instance_v2.terraform-instance.id}"

  # Update apt on server
  provisioner "remote-exec" {
    connection {
      host = "${openstack_networking_floatingip_v2.terraform-floatingip.address}"
      user = "ubuntu"
      type = "ssh"
      private_key = "${file(var.identity_file)}"   
      agent = false
      timeout = "2m"
    }

    inline = [
      "sudo apt update"
    ]
  }
}

resource "local_file" "inventory" {
  content = "[webservers]\n${openstack_networking_floatingip_v2.terraform-floatingip.address}"
  filename = "${path.module}/inventory"

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i inventory ./configuration.yml --extra-vars='ansible_ssh_private_key_file=${var.identity_file}'"
  }

  depends_on = [
    openstack_compute_floatingip_associate_v2.terraform-floatingip
  ]
}

# Print floating ip
output "terraform-public-ip" {
  value = openstack_networking_floatingip_v2.terraform-floatingip.address

  depends_on = [
    openstack_compute_floatingip_associate_v2.terraform-floatingip
  ]
}