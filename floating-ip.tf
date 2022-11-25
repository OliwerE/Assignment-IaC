# Create floating ip
resource "openstack_networking_floatingip_v2" "terraform-floatingip" {
  pool = "public"
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