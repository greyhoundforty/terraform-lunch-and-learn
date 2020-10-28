resource "ibm_compute_vm_instance" "node" {
    count = var.instance_count
  hostname             = "${var.name}-node${count.index+1}"
  domain               = var.domain
  os_reference_code    = var.os_image
  datacenter           = var.datacenter
  network_speed        = 1000
  hourly_billing       = true
  private_network_only = false
  local_disk           = true
  user_metadata        = file("${path.module}/install.yml")
  flavor_key_name      = var.instance_type
  tags                 = [var.datacenter, var.name]
  ssh_key_ids          = [data.ibm_compute_ssh_key.deploymentKey.id]
}