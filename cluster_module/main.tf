

module "master2" {
  source = "../vm_module"
  name = "master2"
  iso = "/var/lib/vz/template/iso/master2.iso"
  memory = 20000
}


module "master3" {
  source = "../vm_module"
  name = "master3"
  iso = "/var/lib/vz/template/iso/master3.iso"
  memory = 20000
}

module "worker1" {
  source = "../vm_module"
  name = "worker1"
  iso = "/var/lib/vz/template/iso/worker1.iso"
  memory = 15000
}


module "worker2" {
  source = "../vm_module"
  name = "worker2"
  iso = "/var/lib/vz/template/iso/worker2.iso"
  memory = 15000
}


module "worker3" {
  source = "../vm_module"
  name = "worker3"
  iso = "/var/lib/vz/template/iso/worker3.iso"
  memory = 15000
}

