#!/bin/bash

set -e

tmpdir=$(sudo mktemp -d -p .)

sudo dpkg -x linux-image-current-rockchip64_21.08.0-trunk_arm64.deb "$tmpdir"
sudo dpkg -x armbian-firmware_21.08.0-trunk_all.deb "$tmpdir"
sudo mv $tmpdir/boot/config-* $tmpdir/boot/config-lts
sudo mv $tmpdir/boot/System.map-* $tmpdir/boot/System.map-lts
sudo mv $tmpdir/boot/vmlinuz-* $tmpdir/boot/vmlinuz-lts
sudo mkdir $tmpdir/boot/dtbs-lts
sudo mv $tmpdir/usr/lib/linux-image-current-rockchip64/* $tmpdir/boot/dtbs-lts
sudo mksquashfs "$tmpdir/lib" "$tmpdir/boot/modloop-lts" -b 1048576 -comp xz -Xdict-size 100%
sudo tar -C "$tmpdir" -cvf alpine-boot.tar boot
sudo rm -rf "$tmpdir"
