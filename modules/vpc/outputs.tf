output subnet_id {
  value = ibm_is_subnet.subnet.id
}

output id {
  value = ibm_is_vpc.vpc.id
}

output security_group_id {
  value = ibm_is_security_group.instance_sg.id
}