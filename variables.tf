variable "proxmox_api_url" {
  type = string
}

variable "allow_tls_insecure" {
  type = bool
}

variable "iso_path" {
  type = string
  description = "The absolute path to the iso folder in the Proxmox."
}

variable "admin_user" {
  type = string
}
variable "admin_password" {
  type = string
  sensitive = true
}

variable "cluster_name" {
  type = string 
}

variable "disk_storage_pool" {
  type = string
  description = "The disk storage pool in Proxmox where the disk will be created"
  default = "local-lvm"
}

variable "target_node" {
  type = string
  description = "The proxmox node to create the VMs on"
}

variable "config_workers" {
  type = object({
    isos = list(string)
    memory = number
    disks = number
    disk_size = string
    disk_storage_pool = string
  })
}

variable "config_masters" {
  type = object({
    isos = list(string)
    memory = number
    disks = number
    disk_size = string
    disk_storage_pool = string
  })
  validation {
    condition = contains([0,1,3,5], length(var.config_masters.isos))
    error_message = "The number of masters can only be 0, 1, 3 or 5."
  }
}



