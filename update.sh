#!/bin/bash

# 解压squashfs的目录

ROOTFS=$PWD/squashfs-root

WORK_DIR=$PWD/work

TOOLS_DIR=$PWD/tools
# 更新图片等

#开始栏logo
cp $WORK_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

# 桌面背景图片
cp $WORK_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

# web访问页面
cp $WORK_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

# 登出logo图片
cp $WORK_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/

# 环境变量
cp $WORK_DIR/etc/bash.bashrc $ROOTFS/etc/

# 终端配置
cp $WORK_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

# 开始菜单
cp $WORK_DIR/menu/panel $ROOTFS/usr/share/lxpanel/profile/Lubuntu/panels/

# 桌面图标(将系统已有的图标放到桌面上)
#mkdir -p $ROOTFS/etc/skel/Desktop
#cd $ROOTFS/etc/skel/Desktop/
#cp $ROOTFS/usr/share/applications/firefox.desktop .
#cp $ROOTFS/usr/share/applications/lxterminal.desktop .
#cp $ROOTFS/usr/share/applications/lubuntu-screenlock.desktop .
#cp $ROOTFS/usr/share/applications/fcitx.desktop .
#chmod +x *
#cd -

# 准备网络环境
cat $WORK_DIR/source/n163.list > $ROOTFS/etc/apt/sources.list
cp /etc/resolv.conf $ROOTFS/etc/

# 更新源
chroot $ROOTFS apt-get update

# 安装软件
chroot $ROOTFS apt-get install -y vim cmake

# 安装firefox38
cp $TOOLS_DIR/firefox-38.0.tar.bz2 $ROOTFS
cp $ROOTFS/usr/share/lintian/overrides/firefox $WORK_DIR/firefox
cp $ROOTFS/usr/share/applications/firefox.desktop $WORK_DIR/firefox

chroot $ROOTFS apt-get remove -y firefox

chroot $ROOTFS tar xjf /firefox-38.0.tar.bz2
chroot $ROOTFS mv /firefox /opt/firefox38
chroot $ROOTFS rm /firefox-38.0.tar.bz2
chroot $ROOTFS ln -s /opt/firefox38/firefox /usr/bin/firefox
cp $WORK_DIR/firefox/firefox $ROOTFS/usr/share/lintian/overrides/firefox
cp $WORK_DIR/firefox/firefox.desktop $ROOTFS/usr/share/applications/firefox.desktop


# 将时区改为东八区
chroot $ROOTFS rm /etc/localtime
chroot $ROOTFS ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 汉化
chroot $ROOTFS apt-get install -y language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hant language-pack-gnome-zh-hant language-pack-en language-pack-gnome-en

# 输入法
chroot $ROOTFS apt-get install -y fcitx-pinyin fcitx-table-wubi fcitx-table-wbpy 

exit

# 卸载软件相关工具
#chroot $ROOTFS apt-get remove -y synaptic lubuntu-software-center gdebi

chroot $ROOTFS rm -rf $(find /usr -name "*dpkg*") $(find /usr -name "*apt*")
chroot $ROOTFS rm -rf $(find /etc -name "*dpkg*") $(find /etc -name "*apt*")
