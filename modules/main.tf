module vpc {
  source            = "./vpc"
  name              = var.name
  resource_group_id = data.ibm_resource_group.group.id
  region            = var.region
  zone              = data.ibm_is_zones.regional_zones.zones[0]
  tags              = var.tags
}

module classic_instance {
  source         = "./classic"
  for_each       = var.environment
  datacenter     = each.value.datacenter
  name           = each.value.name
  instance_count = each.value.instance_count
  instance_type  = each.value.instance_type
}

module object_storage {
  source        = "./object-storage"
  name          = var.name
  regions       = var.icos_regions
  icos_instance = data.ibm_resource_instance.icos_instance.id
}

module private_dns {
  source        = "./pdns"
  count         = length(data.ibm_is_zones.regional_zones.zones)
  name          = "test-${count.index + 1}-domain.local"
  pdns_instance = var.pdns_instance
}