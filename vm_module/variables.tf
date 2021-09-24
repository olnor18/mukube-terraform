variable "os" {
  type = string
}

variable "os_format" {
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

variable "target_node" {
  type = string
}

variable "vm_id" {
  type = number
}

variable "user" {
  description = "The user to do use for ssh connection execution of scripts"
  type = string
}

variable "host" {
  description = "The host to use as an endpoint for remote shh execution"
  type = string
}

variable "password" {
  description = "password for the user to use for the ssh connection"
  type = string
  sensitive = true
}

variable "bios" {
  description = "The BIOS used in the vm"
  type = string
  default = "seabios"
}

variable "scsihw" {
  description = "The SCSI controller to use in the VM"
  type = string
  default = "lsi"
}

