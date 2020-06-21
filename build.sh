#!/bin/bash
clear
echo SeniXa Kernel Build Tool
echo By Advaith Bhat
echo Please Sit Back And Chill...
export MAIN=`readlink -f ../`
export KERNELDIR=`readlink -f .`
rm $KERNELDIR/zip/S*.zip
rm $KERNELDIR/zip/Image.gz-dtb
rm $KERNELDIR/zip/kernel_output.txt
make clean
make mrproper
make ARCH=arm64 RMX1921_defconfig
make -j$(nproc --all) ARCH=arm64 \
        CC="$MAIN/kernel/proton-clang/bin/clang" \
        CROSS_COMPILE="$MAIN/kernel/proton-clang/bin/aarch64-linux-gnu-" \
        CROSS_COMPILE_ARM32="$MAIN/kernel/proton-clang/bin/arm-linux-gnueabi-"
mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/zip/Image.gz-dtb
echo ""
echo "Compile Done"
echo ""
cd $KERNELDIR/zip
zip -r SeniXa-RMX1921-Release-`date +%Y%m%d_%H%M`.zip * -x "kernel_output.txt" "*.zip"
cd $KERNELDIR/
echo "Zip Done"
