terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.6.8"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url = var.proxmox_api_url
  pm_user = var.admin_user
  pm_password = var.admin_password
}

module "masters" {
  count = length(var.config_masters.isos)
  source = "./vm_module"
  name = "master${count.index}"
  iso = var.config_masters.isos[count.index]
  memory = 35000
  disks = var.config_masters.disks
  disk_size = var.config_masters.disk_size
  disk_storage_pool = var.disk_storage_pool
}

module "workers" {
  count = length(var.config_workers.isos)
  source = "./vm_module"
  name = "worker${count.index}"
  iso = var.config_workers.isos[count.index]
  memory = 15000
  disks = var.config_workers.disks
  disk_size = var.config_workers.disk_size
  disk_storage_pool = var.disk_storage_pool
}

