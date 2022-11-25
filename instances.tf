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