# mukube-terraform
A terraform provisioner for Mukube in Proxmox. The module `vm_module` holds a opinionated virtual machine resource that can be reused. The VM has 2 cores and uses a `e1000` network card with a `vmbr0` bridge. The VM also has a connected `vga` of type `virtio` for best UI experience in the Proxmox.
