variable "proxmox_host_endpoint" {
  type = string
  description = "The ip or url of the Proxmox machine"
}

variable "proxmox_api_port" {
  type = string
  description = "The port to connect to the proxmox api on"
  default = "8006"
}

variable "allow_tls_insecure" {
  type = bool
}

variable "os_path" {
  type = string
  description = "The absolute path to the os folder in the Proxmox."
}

variable "os_format" {
  description = "The format of the os"
  type = string
}

variable "admin_user" {
  type = string
  sensitive = true
}

variable "admin_password" {
  type = string
  sensitive = true
}

variable "cluster_name" {
  type = string 
}

variable "target_node" {
  type = string
  description = "The proxmox node to create the VMs on"
}

variable "vms_start_id" {
  type = number
}

variable "config_workers" {
  type = object({
    count = number
    memory = number
    disks = number
    disk_size = string
    disk_storage_pool = string
    bios = string
    scsihw = string
  })
}

variable "config_masters" {
  type = object({
    count = number
    memory = number
    disks = number
    disk_size = string
    disk_storage_pool = string
    bios = string
    scsihw = string
  })
  validation {
    condition = contains([0,1,3,5], var.config_masters.count)
    error_message = "The number of masters can only be 0, 1, 3 or 5."
  }
}



