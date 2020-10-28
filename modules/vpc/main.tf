resource ibm_is_vpc vpc {
  name                      = var.name
  resource_group            = var.resource_group_id
  tags                      = concat(var.tags, ["vpc"])
  address_prefix_management = "auto"
}

resource ibm_is_public_gateway gateway {
  name           = "${var.name}-gateway"
  vpc            = ibm_is_vpc.vpc.id
  zone           = var.zone
  resource_group = var.resource_group_id
}

resource ibm_is_subnet subnet {
  name                     = "${var.name}-subnet"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = var.zone
  resource_group           = var.resource_group_id
  total_ipv4_address_count = 32
  public_gateway           = ibm_is_public_gateway.gateway.id
}

resource "ibm_is_security_group" "instance_sg" {
  name           = "instance-sg"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = var.resource_group_id
}

resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "vpc_allow_in" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "inbound"
  remote    = ibm_is_subnet.subnet.ipv4_cidr_block
}

# from https://cloud.ibm.com/docs/vpc?topic=vpc-service-endpoints-for-vpc
resource "ibm_is_security_group_rule" "cse_dns_1" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.10"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "cse_dns_2" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.11"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_1" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.7"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "private_dns_2" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "161.26.0.8"
  udp {
    port_min = 53
    port_max = 53
  }
}

resource "ibm_is_security_group_rule" "http_out" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group_rule" "https_out" {
  group     = ibm_is_security_group.instance_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 443
    port_max = 443
  }
}