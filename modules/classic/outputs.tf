output "instance_ips" {
  value = ibm_compute_vm_instance.node[*].ipv4_address
}