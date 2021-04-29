#!/usr/bin/env bash

qemu-system-aarch64 \
    -dtb versatile-pb-buster-5.4.51.dtb \
    -kernel kernel-qemu-4.19.50-buster \
    -append 'root=/dev/sda2 panic=1' \
    -cpu arm1176 \
    -m 256 \
    -M versatilepb \
    -serial stdio \
    -hda 2021-03-04-raspios-buster-armhf-lite.img \
    -no-reboot -net user,hostfwd=tcp::2222-:22 -net nic
