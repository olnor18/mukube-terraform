variable "proxmox_api_url" {
  type = string
}
variable "admin_user" {
  type = string
}
variable "admin_password" {
  type = string
  sensitive = true
}

variable "config_workers" {
  type = object({
    isos = list(string)
    memory = number
    disks = number
    disk_size = string
  })
}

variable "config_masters" {
  type = object({
    isos = list(string)
    memory = number
    disks = number
    disk_size = string
  })
  validation {
    condition = contains([1,3,5], length(var.config_masters.isos))
    error_message = "The number of masters can only be 1,3 or 5."
  }
}



