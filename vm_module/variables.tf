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
