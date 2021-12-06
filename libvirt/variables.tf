variable "libvirt_uri" {
  type = string
}

variable "mukube_image" {
  type = string
}

variable "mukube_config_image" {
  type = list(string)
}

variable "cidr_subnet" {
  type = string
}

variable "machines" {
  type = number
  # This should be changed to null when Terraform v1.1.0 is released:
  # https://github.com/hashicorp/terraform/blob/16800d1305f3b9035095683e5cdeb64ea286f845/website/docs/language/values/variables.html.md#disallowing-null-module-input-values
  default = 1
}

variable "vcpus" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 8192
}

variable "extra_disks" {
  type    = number
  default = 0
}

variable "extra_disk_size" {
  type    = number
  default = 20
}
