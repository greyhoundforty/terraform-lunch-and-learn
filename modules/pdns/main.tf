resource "ibm_dns_zone" "pdns_zone" {
  name        = var.name
  instance_id = var.pdns_instance
  description = "testdescription"
  label       = "testlabel"
}
