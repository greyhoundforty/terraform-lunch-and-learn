resource random_id name {
  byte_length = 4
}

resource ibm_is_vpc vpc {
  name           = "${var.name}-${random_id.name.hex}-vpc"
  tags           = concat(var.tags, ["vpc"])
  resource_group = var.resource_group_id
}

resource ibm_is_public_gateway zone_gateway {
  name           = "${var.name}-${random_id.name.hex}-gateway"
  tags           = ["ryantiffany", "public-gateway"]
  resource_group = var.resource_group_id
  vpc            = ibm_is_vpc.vpc.id
  zone           = "${var.region}-1"
}

resource ibm_is_subnet zone_subnet {
  name                     = "${var.name}-${random_id.name.hex}-subnet"
  resource_group           = var.resource_group_id
  zone                     = "${var.region}-1"
  public_gateway           = ibm_is_public_gateway.zone_gateway.id
  vpc                      = ibm_is_vpc.vpc.id
  total_ipv4_address_count = 256
}

resource ibm_is_security_group vpc_security_group {
  name           = "${var.name}-${random_id.name.hex}-security-group"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = var.resource_group_id
}

resource ibm_is_security_group_rule all_in {
  group     = ibm_is_security_group.vpc_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
}

resource ibm_is_security_group_rule all_out {
  group     = ibm_is_security_group.vpc_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_instance" "instance" {
  count          = var.instance_count
  name           = "${var.name}-${random_id.name.hex}-instance-${count.index + 1}"
  vpc            = ibm_is_vpc.vpc.id
  zone           = "${var.region}-1"
  resource_group = var.resource_group_id
  profile        = var.profile_name
  image          = var.image_id
  keys           = [var.ssh_key_id]

  primary_network_interface {
    subnet          = ibm_is_subnet.zone_subnet.id
    security_groups = [ibm_is_security_group.vpc_security_group.id]
  }

  boot_volume {
    name = "${var.name}-${random_id.name.hex}-boot-${count.index + 1}"
  }

  tags = concat(var.tags, ["instance"])
}