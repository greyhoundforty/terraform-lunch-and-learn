data "ibm_is_zones" "regional_zones" {
  region = var.region
}

data "ibm_is_ssh_key" "key" {
  name = var.ssh_key
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}

data "ibm_is_subnet" "subnet" {
  name = var.subnet
}

data "ibm_is_security_group" "group" {
  name = var.security_group
}

data ibm_is_image image {
  name = var.image_name
}