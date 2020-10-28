variable resource_group {}
variable zone {}
variable subnet {}
variable vpc {}

variable image_name {
  default = "ibm-ubuntu-20-04-minimal-amd64-2"
}

variable profile {
  default = "cx2-2x4"
}

variable tags {}

variable ssh_key {
  default = "hyperion-jp-tok"
}

variable security_group {}

variable name {}