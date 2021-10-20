terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}

variable "libvirt_uri" {
  type = string
}

variable "mukube_image" {
  type = string
}

variable "mukube_config_image" {
  type = list(string)
}

variable "machines" {
  type    = number
  default = 1
}

variable "extra_disks" {
  type    = number
  default = 0
}

variable "extra_disk_size" {
  type    = number
  default = 20
}

resource "random_id" "cluster_id" {
  byte_length = 4
}

locals {
  extra_disks = [for i in range(var.machines) :
    [for d in range(var.extra_disks) : "${i}-${d}"]
  ]
}

resource "libvirt_volume" "mukube" {
  name   = "mukube-${random_id.cluster_id.hex}-${basename(var.mukube_image)}"
  source = var.mukube_image
}

resource "libvirt_volume" "mukube_disk" {
  count          = var.machines
  name           = "mukube-${random_id.cluster_id.hex}-${count.index}"
  base_volume_id = libvirt_volume.mukube.id
}

resource "libvirt_volume" "mukube_config" {
  count  = var.machines
  name   = "mukube-${random_id.cluster_id.hex}-config-${count.index}"
  source = var.mukube_config_image[count.index]
}

resource "libvirt_volume" "extra" {
  for_each = toset(flatten(local.extra_disks))
  name     = "mukube-${random_id.cluster_id.hex}-extra-${each.key}"
  size     = 1024 * 1024 * 1024 * var.extra_disk_size
}

resource "libvirt_domain" "node" {
  count    = var.machines
  name     = "mukube-${random_id.cluster_id.hex}-${count.index}"
  machine  = "q35"
  memory   = 8192
  vcpu     = 2
  firmware = "/usr/share/OVMF/OVMF_CODE_4M.secboot.fd"
  nvram {
    file     = ""
    template = "/usr/share/OVMF/OVMF_VARS_4M.fd"
  }

  network_interface {
    network_name = "default"
  }

  disk {
    volume_id = libvirt_volume.mukube_disk[count.index].id
    scsi      = "true"
  }

  disk {
    volume_id = libvirt_volume.mukube_config[count.index].id
    scsi      = "true"
  }

  dynamic "disk" {
    for_each = local.extra_disks[count.index]
    content {
      volume_id = libvirt_volume.extra[disk.value].id
      scsi      = "true"
    }
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  xml {
    # Add TPM device and enable websocket
    xslt = file("xslt-tweaks.xsl")
  }
}
