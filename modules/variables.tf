variable resource_group {
  default = "CDE"
}

variable icos_regions {
  default = ["us-south", "us-east", "jp-tok"]
}

variable name {
  default = "module-example"
}

variable tags {
  default = ["terraform", "ryantiffany"]
}

variable region {
  default = "jp-tok"
}

variable ibmcloud_timeout {
  default = 900
}

variable environment {
  description = "Map of project names to configuration."
  type        = map
  default = {
    dev = {
      datacenter     = "wdc06"
      instance_count = 3,
      instance_type  = "BL2_2X4X100",
      name           = "development"
    },
    qa = {
      datacenter     = "dal13"
      instance_count = 2,
      instance_type  = "BL2_4X8X100",
      name           = "qa"
    },
    prod = {
      datacenter     = "wdc07"
      instance_count = 5,
      instance_type  = "BL2_8X32X100",
      name           = "production"
    }
  }
}