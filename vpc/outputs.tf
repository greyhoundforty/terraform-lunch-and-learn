output instance_ips {
  value = ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address
}