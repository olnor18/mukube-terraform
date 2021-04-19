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

module "master1" {
  source = "./vm_module"
  name = "master1"
  iso = "/var/lib/vz/template/iso/master1.iso"
  memory = 35000
}

module "cluster" {
  source = "./cluster_module"
  depends_on = [
    module.master1,
  ]
}
