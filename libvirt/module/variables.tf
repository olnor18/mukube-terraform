variable "libvirt_uri" {
  type = string
}

variable "cluster_id" {
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
  type    = number
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
