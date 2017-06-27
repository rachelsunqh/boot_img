#!/bin/bash
losetup -d /dev/loop7
rm -rf ./disk.img
dd if=/dev/zero of=./disk.img bs=4096 count=8192
losetup /dev/loop7 disk.img
fdisk /dev/loop7
mkfs.ext4 /dev/loop7 
mount /dev/loop7 /mnt
mkdir /mnt/boot
grub-install --boot-directory=/mnt/boot --force /dev/loop7

umount /mnt
losetup -d /dev/loop7
qemu-system-i386 -hda disk.img
