resource "ibm_is_instance" "instance" {
  count          = "3"
  name           = "${var.vpc_name}-instance${count.index + 1}"
  vpc            = data.ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  resource_group = data.ibm_resource_group.group.id
  profile        = var.profile
  image          = data.ibm_is_image.image.id
  keys           = [data.ibm_is_ssh_key.key.id]

  primary_network_interface {
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = [data.ibm_is_security_group.group.id]
  }

  boot_volume {
    name = "${var.vpc_name}-boot-${count.index + 1}"
  }

  tags = concat(var.tags, ["vpc"])
}