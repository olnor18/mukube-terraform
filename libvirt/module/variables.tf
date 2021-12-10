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
  type     = number
  nullable = false
  default  = 1
}

variable "vcpus" {
  type     = number
  nullable = false
  default  = 2
}

variable "memory" {
  type     = number
  nullable = false
  default  = 8192
}

variable "extra_disks" {
  type     = number
  nullable = false
  default  = 0
}

variable "extra_disk_size" {
  type     = number
  nullable = false
  default  = 20
}
