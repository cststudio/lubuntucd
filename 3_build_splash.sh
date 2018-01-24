#!/bin/bash
# 用法：3_build_splash.sh
# 功能：
#  制作开机画面和开机文字
#  和2_tar_splash.sh配合使用
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

echo "making boologo"

# 进入该目录操作
cd $LOGO_DIR/

# 删除之，因为我们会再生成
rm -rf bootlogo

# !!!!!!
# 这里开始定制！
cp -rf $WORK_DIR/{splash.pcx,en.tr,zh_CN.tr,zh_TW.tr,txt.cfg} .
cp -rf $WORK_DIR/{splash.pcx,en.tr,zh_CN.tr,zh_TW.tr,txt.cfg} $ISO_IDR/isolinux
# !!!!!!

# 获取当前目录所有文件
ls > /tmp/list
# 重新制作bootlogo
cpio -o < /tmp/list > /tmp/bootlogo
# 拷贝回原始位置
mv /tmp/bootlogo $ISO_IDR/isolinux/bootlogo

# 返回上一级目录
cd -

##############################

echo "making initrd"

cd $INITRD_DIR

# !!!!!!
# 这里开始定制！

mkdir -p /usr/share/plymouth/themes/lubuntu-logo/
mkdir -p /usr/share/plymouth/themes/lubuntu-text/

cp -rf $WORK_DIR/{lubuntu_logo.png,progress_dot_on.png} \
usr/share/plymouth/themes/lubuntu-logo/

# 下面2个文件要复制到主机上，否则无法出现界面
# 原因：usr/share/plymouth/themes/的default.plymouth和
# text.plymouth需要是链接文件。
cp -rf usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth \
/usr/share/plymouth/themes/lubuntu-logo/

cp -rf usr/share/plymouth/themes/lubuntu-text/lubuntu-text.plymouth  \
 /usr/share/plymouth/themes/lubuntu-text/

# !!!!!!

# 压缩，并拷贝到原来位置
find . | cpio --quiet --dereference -o -H newc | lzma -7 > $ISO_IDR/casper/initrd.lz

cd -