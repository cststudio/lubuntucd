#!/bin/bash
# Author：Late Lee<li@latelee.org>
# 用法：./1_tar.iso.sh xxx.iso
# 功能：
# 解压ubuntu livecd的iso，得到其中的rootfs
# 最终得到的目录有2个，分别为：
# squashfs-root：在此目录chroot，就是一个系统，可以安装各种软件、修改背景图片，等等
# newiso：重新制定iso需要的源文件

# 这是默认的原始镜像包名称，不指定ISO则使用此文件
ISO_NAME=lubuntu-16.04.3-desktop-amd64.iso

# 保证是root权限
if [ `whoami` != "root" ];then
    echo "you are not root! try: -s"
    exit
fi

# 如果用户输入指定的iso名，则使用之
if [ $# -gt 0 ]; then
    echo "will try iso" $1
    ISO_NAME=$1
fi

# 创建存储文件的目录，其中foo是临时目录，会即时被删除。
mkdir -p foo newiso
mount $ISO_NAME foo/ -o loop
cp  -a  foo/* newiso/
cp -av foo/.disk newiso/
umount foo/
rm -rf foo/

# 进入newiso，将其中的压缩文件系统解压
cd newiso
unsquashfs casper/filesystem.squashfs
mv squashfs-root ../ # 单独移到另外目录
cd ..

# 注：这里将主机的resolv.conf拷贝到新的文件系统目录中，
# 这样chroot后，就可以使用网络了。
# 当然，前提是主机的resolv.conf是能正常工作的。
cp /etc/resolv.conf  squashfs-root/etc

# 下面的未测试，先注释掉
#chroot  squashfs-root
#mount none  /proc -t  proc # 此语句存疑
#mknod /dev/urandom c 1 9

