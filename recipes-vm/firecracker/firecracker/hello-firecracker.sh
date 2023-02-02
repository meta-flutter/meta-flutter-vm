#!/bin/sh

arch=`uname -m`
dest_kernel="hello-vmlinux.bin"
dest_rootfs="hello-rootfs.ext4"
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img/quickstart_guide/$a
rch"

if [ ${arch} = "x86_64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin"
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4"
elif [ ${arch} = "aarch64" ]; then
    kernel="${image_bucket_url}/kernels/vmlinux.bin"
    rootfs="${image_bucket_url}/rootfs/bionic.rootfs.ext4"
else
    echo "Cannot run firecracker on $arch architecture!"
    exit 1
fi

echo "Downloading $kernel..."
curl -fsSL --progress-bar -o $dest_kernel $kernel

echo "Downloading $rootfs..."
curl -fsSL --progress-bar -o $dest_rootfs $rootfs

echo "Saved kernel file to $dest_kernel and root block device to $dest_rootfs."

rm -rf /tmp/firecracker.socket |true

firecracker --api-sock /tmp/firecracker.socket --config-file hello-conf.json
