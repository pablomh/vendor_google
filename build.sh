#!/usr/bin/env bash

# ccache
export USE_CCACHE=1
export KBUILD_BUILD_USER=$USER

# erikcas: lower cchace
prebuilts/misc/linux-x86/ccache/ccache -M 32G

echo "INFO: before start to build change $device-userdebug"
echo " with your device model.... Ex. c6903-userdebug for "
echo " build AOSP for Sony Xperia Z1 (honami - c6903).... "

repo sync

rm -rf out
. build/envsetup.sh
lunch aosp_$device-userdebug

# ENABLED by default
make -j$(grep -c ^processor /proc/cpuinfo) dist

# ENABLE this for make recovery and kernel images
#make recoveryimage
