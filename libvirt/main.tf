terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

resource "random_id" "cluster_id" {
  byte_length = 4
}

module "mukube_libvirt" {
  source = "./module"

  libvirt_uri         = var.libvirt_uri
  cluster_id          = random_id.cluster_id.hex
  mukube_image        = var.mukube_image
  mukube_config_image = var.mukube_config_image
  cidr_subnet         = var.cidr_subnet
  machines            = var.machines
  vcpus               = var.vcpus
  memory              = var.memory
  extra_disks         = var.extra_disks
  extra_disk_size     = var.extra_disk_size
}
