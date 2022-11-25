resource "local_file" "inventory" {
  content = "[webservers]\n${openstack_networking_floatingip_v2.terraform-floatingip.address}"
  filename = "${path.module}/inventory"

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i inventory ./ansible-playbook.yml --extra-vars='ansible_ssh_private_key_file=${var.identity_file}'"
  }

  depends_on = [
    openstack_compute_floatingip_associate_v2.terraform-floatingip
  ]
}