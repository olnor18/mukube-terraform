variable "iso" {
  type = string
}

variable "name" {
  type = string
}

variable "memory" {
    type = number
}

variable "disk_type" {
  type = string
  default = "sata"
}

variable "disks" {
  type = number
  description = "The number of disks to attach to the vm"  
}

variable "disk_size" {
  type = string
}

variable "disk_storage_pool" {
  type = string
}
