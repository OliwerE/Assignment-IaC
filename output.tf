# Print floating ip
output "terraform-public-ip" {
  value = openstack_networking_floatingip_v2.terraform-floatingip.address

  depends_on = [
    openstack_compute_floatingip_associate_v2.terraform-floatingip
  ]
}