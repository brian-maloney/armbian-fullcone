#!/bin/bash

set -e

BRANCH=current

git clone https://github.com/armbian/build.git
mkdir -p build/userpatches/kernel/rockchip64-"$BRANCH"/
cp fullcone.patch build/userpatches/kernel/rockchip64-"$BRANCH"/
cd build
echo 'CONFIG_NETFILTER_XT_TARGET_FULLCONENAT=m' >> config/kernel/linux-rockchip64-"$BRANCH".config 
./compile.sh BOARD='nanopi-r2s' BRANCH="$BRANCH" KERNEL_ONLY=yes KERNEL_CONFIGURE=no