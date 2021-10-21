# libvirt

## Instructions

1. [Build mukube image](https://github.com/distributed-technologies/mukube)
1. Build mukube config disk(s) with [mukube-configurator](https://github.com/distributed-technologies/mukube-configurator)
1. Create `terraform.tfvars` file:
    ```hcl
    # https://github.com/dmacvicar/terraform-provider-libvirt/issues/886
    libvirt_uri         = "qemu+ssh://root@1.2.3.4/system?keyfile=/home/foobar/.ssh/id_ed25519&sshauth=privkey"
    machines            = 1
    extra_disks         = 2
    extra_disk_size     = 10
    cidr_subnet         = "192.168.1.0/24"
    mukube_image        = "images/mukube-dev-image-mukube-20211004124859.rootfs.wic"
    mukube_config_image = ["../../mukube-configurator/artifacts/test-master0.ext4"]
    ```
1. Run `terraform apply` to deploy the cluster and `terraform destroy` to delete it

The console can be accessed with: `virsh console <domain>`
