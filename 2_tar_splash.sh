#!/bin/bash
# 用法：./2_tar_splash.sh
# 功能：
#  解压制作开机画面和开机文字文件
#  和3_build_splash.sh配合使用
# 目录：
# $ISO_IDR：重新制定iso需要的源文件
# $LOGO_DIR：负责最开始界面的显示（即试用、安装选项）
# $INITRD_DIR：负责开机过程的界面显示

# 需要定制的文件目录
WORK_DIR=$PWD/work/splash

# 定制临时目录
SPLASH_DIR=$PWD/splash_dir

LOGO_DIR=$SPLASH_DIR/bootlogo

INITRD_DIR=$SPLASH_DIR/initrd


# 光盘解压后的目录
ISO_IDR=$PWD/newiso

# 保证是root权限
if [ `whoami` != "root" ];then
    echo "you are not root! try: sudo -s"
    exit
fi

mkdir -p $SPLASH_DIR
mkdir -p $LOGO_DIR
mkdir -p $INITRD_DIR

# 先删除文件，——如果有的话
rm -rf $LOGO_DIR/* $INITRD_DIR/*

# 拷贝bootlogo到$LOGO_DIR目录
cp $ISO_IDR/isolinux/bootlogo $LOGO_DIR/

# 进入该目录操作
cd $LOGO_DIR/

# 解压bootlogo文件
cpio -idmv < bootlogo
# 删除之，因为我们会再生成
rm -rf bootlogo

##############################

cd $INITRD_DIR
lzma -dc -S .lz $ISO_IDR/casper/initrd.lz | cpio -id

# !!!!!!
# 这里开始定制！
