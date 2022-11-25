# Print floating ip
output "terraform-public-ip" {
  value = openstack_networking_floatingip_v2.terraform-floatingip.address
}