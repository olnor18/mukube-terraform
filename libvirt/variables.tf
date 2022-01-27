variable "libvirt_uri" {
  type = string
}

variable "cluster_id_prefix" {
  type    = string
  default = ""
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
  type    = number
  default = null
}

variable "vcpus" {
  type    = number
  default = null
}

variable "memory" {
  type    = number
  default = null
}

variable "extra_disks" {
  type    = number
  default = null
}

variable "extra_disk_size" {
  type    = number
  default = null
}
