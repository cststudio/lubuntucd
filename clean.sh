#!/bin/bash
# 功能：删除临时缓存或临时文件
# 用法：

# 解压squashfs的目录
ROOTFS=squashfs-root

rm -rf $ROOTFS/var/cache/lsc_packages.db
rm -rf $ROOTFS/var/cache/apt/{pkgcache.bin srcpkgcache.bin}
rm -rf $ROOTFS/var/cache/apt/archives/*.deb
rm -rf $ROOTFS/var/lib/{apt,dpkg,cache,log}
