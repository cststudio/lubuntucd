#!/bin/bash

# 解压squashfs的目录
ROOTFS=$PWD/squashfs-root

WORD_DIR=$PWD/work

#开始栏logo
cp $WORD_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

# 桌面背景图片
cp $WORD_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

# web访问页面
cp $WORD_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

# 登出logo图片
cp $WORD_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/


# 环境变量
cp $WORD_DIR/etc/bash.bashrc $ROOTFS/etc/

# 终端配置
cp $WORD_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

# 时区
rm -rf $ROOTFS/etc/localtime
cp $ROOTFS/usr/share/zoneinfo/Asia/Shanghai $ROOTFS/etc/localtime




