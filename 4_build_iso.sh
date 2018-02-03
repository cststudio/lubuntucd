#!/bin/bash
# Author：Late Lee<li@latelee.org>
# 用法：./4_build_iso.sh
# 本脚本必须在目录iso中执行，iso目录有newiso、squashfs-root目录
# 下面的ISO_IDR和ROOTFS必须保持与1_tar_iso.sh脚本中的一致

# 光盘解压后的目录
ISO_IDR=$PWD/newiso
# 解压squashfs的目录
ROOTFS=$PWD/squashfs-root

# 最后生成的镜像的名称，即我们启动、烧写所用的iso镜像
ISO_NAME=$PWD/lubuntu-16.04.3-desktop-amd64-KXS.iso

# xorriso必须依赖此文件，否则烧写U盘系统会无法启动
ISOHDPFX_FILE=$PWD/work/isolinux/isohdpfx.bin

#################################################################
# 恢复resolv.conf的原始值
echo "" > $ROOTFS/etc/resolv.conf

# 创建myversion以记录信息，此文件可以删除
echo "Lubuntu by Late Lee<li@latelee.org>" > squashfs-root/etc/myversion
date >> squashfs-root/etc/myversion

# 删除urandom文件
rm -rf squashfs-root/dev/urandom

# 下面的命令原版从ubuntu的wiki获取，并稍有修改
# >>>>>>>>>>>>>>>>>>>>> 开始
chmod +w $ISO_IDR/casper/filesystem.manifest
# 系统安装的软件包信息
# 
cp /usr/bin/dpkg-query $ROOTFS/usr/bin/
chroot $ROOTFS dpkg-query -W --showformat='${Package} ${Version}\n' > $ISO_IDR/casper/filesystem.manifest
cp $ISO_IDR/casper/filesystem.manifest $ISO_IDR/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' $ISO_IDR/casper/filesystem.manifest-desktop
sed -i '/casper/d' $ISO_IDR/casper/filesystem.manifest-desktop

# 开始压缩
rm -rf  $ISO_IDR/casper/filesystem.squashfs
echo "making squashfs..."
mksquashfs $ROOTFS $ISO_IDR/casper/filesystem.squashfs

# 获取文件系统大小，并存储在配置文件中
printf $(du -sx --block-size=1 $ROOTFS | cut -f1) > $ISO_IDR/casper/filesystem.size
SIZE=`cat $ISO_IDR/casper/filesystem.size`
echo "we got fs size:"  $SIZE

# 重新生成md5
echo "making iso..."
cd $ISO_IDR
rm -rf md5sum.txt
find -type f -print0 | xargs -0 md5sum | grep -v isolinux/boot.cat | tee md5sum.txt

# 制作iso
# 注：-V是打标签的意思
#mkisofs -D -r -V "lubuntu-KXS 16.04.3" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ../$ISO_NAME .

# 注：使用xorriso制作的ISO，用dd烧写到U盘，才能启动，用mkisofs不成功。原因未知
# 但是，这两个工具制作出来的ISO，均可用vmware启动
# 这里以U盘启动为验证标准
xorriso -as mkisofs \
  -v -R -J -joliet-long -input-charset utf8 \
  -publisher "KXS" -p "Late Lee" -V "lubuntu-KXS 16.04.3" \
  -isohybrid-mbr $ISOHDPFX_FILE \
  -c isolinux/boot.cat -b isolinux/isolinux.bin \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -eltorito-alt-boot -e boot/grub/efi.img \
  -no-emul-boot  -isohybrid-gpt-basdat \
  -o $ISO_NAME .

# <<<<<<<<<< 结束
