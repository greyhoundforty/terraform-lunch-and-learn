data ibm_is_image image {
  name = var.image_name
}

data "ibm_is_ssh_key" "key" {
  name = var.ssh_key
}
