resource ibm_is_vpc vpc {
  name           = "${var.name}-vpc"
  tags           = ["ryantiffany", "vpc"]
  resource_group = var.resource_group_id
}

resource ibm_is_public_gateway zone_gateway {
  name           = "${var.name}-gateway"
  tags           = ["ryantiffany", "public-gateway"]
  resource_group = var.resource_group_id
}

resource ibm_is_subnet zone_subnet {
  name                     = "${var.name}-subnet"
  tags                     = ["ryantiffany", "public-gateway"]
  resource_group           = var.resource_group_id
  zone                     = "${var.region}-1"
  public_gateway           = ibm_is_public_gateway.zone_gateway.id
  total_ipv4_address_count = 32
}

resource ibm_is_security_group vpc_security_group {
  name           = "${var.name}-security-group"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = var.resource_group_id
}