terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

locals {
  extra_disks = [for i in range(var.machines) :
    [for d in range(var.extra_disks) : "${i}-${d}"]
  ]
}

resource "libvirt_volume" "mukube" {
  name   = "mukube-${var.cluster_id}-${basename(var.mukube_image)}"
  source = var.mukube_image
}

resource "libvirt_volume" "mukube_disk" {
  count          = var.machines
  name           = "mukube-${var.cluster_id}-${count.index}"
  base_volume_id = libvirt_volume.mukube.id
}

resource "libvirt_volume" "mukube_config" {
  count  = var.machines
  name   = "mukube-${var.cluster_id}-config-${count.index}"
  source = var.mukube_config_image[count.index]
}

resource "libvirt_volume" "extra" {
  for_each = toset(flatten(local.extra_disks))
  name     = "mukube-${var.cluster_id}-extra-${each.key}"
  size     = 1024 * 1024 * 1024 * var.extra_disk_size
}

resource "libvirt_network" "network" {
  name      = "mukube-${var.cluster_id}-net"
  addresses = [var.cidr_subnet]
  mode      = "none"
  dhcp {
    enabled = true
  }
  dns {
    enabled = true
  }
  xml {
    # Set the network forward mode to open.
    xslt = file("${path.module}/xslt-network-tweaks.xsl")
  }
  lifecycle {
    # Temporary hack untill open is available in the provider
    ignore_changes = [mode]
  }
}

resource "libvirt_domain" "node" {
  count    = var.machines
  name     = "mukube-${var.cluster_id}-${count.index}"
  machine  = "q35"
  memory   = var.memory
  vcpu     = var.vcpus
  firmware = "/usr/share/OVMF/OVMF_CODE_4M.secboot.fd"
  nvram {
    file     = ""
    template = "/usr/share/OVMF/OVMF_VARS_4M.fd"
  }

  network_interface {
    network_id = libvirt_network.network.id
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
    xslt = file("${path.module}/xslt-tweaks.xsl")
  }
}
