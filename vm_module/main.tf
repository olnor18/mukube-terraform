terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.6.8"
    }
  }
}

resource "proxmox_vm_qemu" "node"  {
    name = var.name
    desc = "A mukube test node"
    target_node = var.target_node
    iso = var.iso
    memory = var.memory
    cores = 2
    balloon = 1
    guest_agent_ready_timeout = 120
    
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
