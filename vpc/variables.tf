variable name {
  description = "Name to prepend to resources"
  type        = string
  default     = ""
}

variable region {
  description = "Region where resources will be deployed"
  type        = string
  default     = ""
}

variable resource_group_id {
  description = "Resource group ID"
  type        = string
  default     = ""
}

variable ssh_key_id {
  description = "SSH Key ID to add to compute instance"
  type        = string
  default     = ""
}

variable profile_name {
  description = "Compute instance profile"
  type        = string
  default     = ""
}

variable image_id {
  description = "OS image ID for compute instances."
  type        = string
  default     = ""
}

variable instance_count {
  description = "Number of compute instances to deploy."
  type        = string
  default     = "2"
}

variable tags {
  default = ["ryantiffany", "terraform"]
}

variable ibmcloud_timeout {
  default = 900
}
