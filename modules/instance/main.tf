resource "ibm_is_instance" "instance" {
  count          = "3"
  name           = "${var.name}-instance${count.index + 1}"
  vpc            = var.vpc
  zone           = var.zone
  resource_group = var.resource_group
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [var.ssh_key]

  # inject dns config
  user_data = file("${path.module}/bastion-init.sh")

  primary_network_interface {
    subnet          = var.subnet
    security_groups = [var.security_group]
  }

  boot_volume {
    name = "${var.name}-boot-${count.index + 1}"
  }

  tags = concat(var.tags, ["instance"])
}