variable resource_group {
  default = "CDE"
  type    = string
}

variable vpc_name {
  default = "flowlogexample"
  type    = string
}

variable ssh_key {
  default = "hyperion-au-syd"
  type    = string
}

variable region {
  default = "au-syd"
  type    = string
}

variable subnet {
  default = "flowlogexample-au-syd-1-subnet"
  type    = string
}

variable security_group {
  default = "flowlogexample-bastion-security-group"
}

variable image_name {
  default = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}

variable profile {
  default = "cx2-2x4"
}

variable tags {
  default = ["ryantiffany", "datasource"]
}

variable ibmcloud_timeout {
    default = 900
}