resource random_id bucket_name {
  byte_length = 6
}

resource "ibm_cos_bucket" "buckets" {
  count                = length(var.regions)
  bucket_name          = "${var.name}-${random_id.bucket_name.hex}-bucket-${count.index + 1}"
  resource_instance_id = var.icos_instance
  region_location      = var.regions[count.index]
  storage_class        = "smart"
}