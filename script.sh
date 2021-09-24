#!/bin/bash
VM_ID=$1
OS_PATH=$2
STORAGE_POOL=$3
# The new imported disk will get a name that depends on the current number of disks for the vm 
DISK_COUNT=$4

qm stop "$VM_ID"
qm importdisk "$VM_ID" "$OS_PATH" "$STORAGE_POOL"
qm set "$VM_ID" --scsi0 "$STORAGE_POOL:vm-$VM_ID-disk-$DISK_COUNT"
qm set "$VM_ID" --boot order=scsi0
qm start "$VM_ID"
