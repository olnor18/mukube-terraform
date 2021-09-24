terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.7.4"
    }
  }
}

resource "proxmox_vm_qemu" "node"  {
    name = var.name
    desc = "A mukube test node"
    target_node = var.target_node
    iso = var.image_format == "iso" ? var.image_path : "/var/lib/vz/template/wic/alphine-noop.iso" #'iso' is a required field
    memory = var.memory
    cores = 2
    balloon = 1
    guest_agent_ready_timeout = 10
    vmid = var.vm_id
    bios = var.bios
    scsihw = var.scsihw
    
    network {
      model = "e1000"
      bridge = "vmbr0"
    }

    dynamic "disk" {
      for_each = range(var.disks)
      content {
        type = var.disk_type
        storage = var.disk_storage_pool
        size = var.disk_size
      }
    }

    vga {
      type = "virtio"
    }
}
