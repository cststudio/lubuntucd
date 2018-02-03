#!/bin/bash
# 更新rootfs

# 目录定义
ROOTFS=$PWD/squashfs-root

WORK_DIR=$PWD/work

TOOLS_DIR=$PWD/tools

############# 开始栏logo
cp $WORK_DIR/destop_images/start/* $ROOTFS/usr/share/lubuntu/images/

############# 桌面背景图片
cp $WORK_DIR/destop_images/wallpapers/* $ROOTFS/usr/share/lubuntu/wallpapers/

############# web访问页面
cp $WORK_DIR/destop_images/startpage/* $ROOTFS/usr/share/lubuntu/startpage

############# 登出logo图片
cp $WORK_DIR/destop_images/themes/lubuntu_logo.png $ROOTFS/usr/share/plymouth/themes/lubuntu-logo/

############# 环境变量
cp $WORK_DIR/etc/bash.bashrc $ROOTFS/etc/

############# 终端配置
cp $WORK_DIR/etc/lxterminal.conf $ROOTFS/usr/share/lxterminal/

############# 准备网络环境
cat $WORK_DIR/source/n163.list > $ROOTFS/etc/apt/sources.list
cp /etc/resolv.conf $ROOTFS/etc/

############# 更新源
chroot $ROOTFS apt-get update

############# 安装软件
chroot $ROOTFS apt-get install -y vim cmake

# <<<<<<<<<< 安装firefox38
# 拷贝安装包
mkdir -p $TOOLS_DIR

if [ ! -f $TOOLS_DIR/firefox-38.0.tar.bz2 ]; then
echo "downloading firefox..."
wget -P $TOOLS_DIR http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/firefox-38.0.tar.bz2
fi

cp $TOOLS_DIR/firefox-38.0.tar.bz2 $ROOTFS
# 备份桌面图标
cp $ROOTFS/usr/share/lintian/overrides/firefox $WORK_DIR/firefox
cp $ROOTFS/usr/share/applications/firefox.desktop $WORK_DIR/firefox
# 卸载默认的firefox
chroot $ROOTFS apt-get remove -y firefox
# 解压、安装、创建链接
chroot $ROOTFS rm -rf /opt/firefox /usr/bin/firefox
chroot $ROOTFS tar xjf /firefox-38.0.tar.bz2 -C /opt
chroot $ROOTFS rm -rf /firefox-38.0.tar.bz2
chroot $ROOTFS ln -s /opt/firefox/firefox /usr/bin/firefox
# (注：桌面任务栏图标使用的是x-www-browser连接)
chroot $ROOTFS ln -s /usr/bin/firefox /usr/bin/x-www-browser

#恢复桌面图标
cp $WORK_DIR/firefox/firefox $ROOTFS/usr/share/lintian/overrides/firefox
cp $WORK_DIR/firefox/firefox.desktop $ROOTFS/usr/share/applications/firefox.desktop
# >>>>>>>>>>>>>>>>>>firefox38安装结束

echo "copying desktop..."

mkdir -p $ROOTFS/etc/skel/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

NEW_DESKTOP=$ROOTFS/etc/skel/Desktop

############## 桌面图标(将系统已有的图标放到桌面上)位于Desktop目录下
# 火狐浏览器
cp $ROOTFS/usr/share/applications/firefox.desktop $NEW_DESKTOP
# 终端
cp $ROOTFS/usr/share/applications/lxterminal.desktop $NEW_DESKTOP

# 用这种方式，如果不拷贝ubiquity.desktop，则双击图标无法安装
# 注：ubiquity.desktop已经修改过了
cp $WORK_DIR/etc/ubiquity.desktop $ROOTFS/usr/share/applications/ubiquity.desktop
cp $WORK_DIR/etc/ubiquity.desktop $NEW_DESKTOP

# home目录和根目录(注：此二项是新加的)
cp $WORK_DIR/etc/pcmanfm_home.desktop $NEW_DESKTOP
cp $WORK_DIR/etc/pcmanfm_rootfs.desktop $NEW_DESKTOP

#下面自行添加要在桌面显示的图标

############## 拷贝鼠标样式、主题
cp -a $WORK_DIR/lubuntu/.config $NEW_DESKTOP/../
cp -a $WORK_DIR/lubuntu/.icons $NEW_DESKTOP/../

############# 菜单分类示例
cp $WORK_DIR/etc/myvim.desktop $ROOTFS/usr/share/applications/myvim.desktop

############# 锁屏
# 图标
cp $WORK_DIR/xlock/xlock.desktop $ROOTFS/usr/share/applications/
cp $WORK_DIR/xlock/xlock.desktop $NEW_DESKTOP
#锁屏工具
cp $WORK_DIR/xlock/xlock $ROOTFS/usr/sbin
cp $WORK_DIR/xlock/xlockless $ROOTFS/usr/sbin
chmod 777 $ROOTFS/usr/sbin/xlock*

chroot $ROOTFS cp /lib64/ld-linux-x86-64.so.2 /lib/

############# 将时区改为东八区
chroot $ROOTFS rm /etc/localtime
chroot $ROOTFS ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

############# 汉化
chroot $ROOTFS apt-get install -y language-pack-zh-hans language-pack-gnome-zh-hans language-pack-zh-hant language-pack-gnome-zh-hant language-pack-en language-pack-gnome-en

############# 语言文件修改测试(用已修改过的mo文件覆盖)
cp $WORK_DIR/i18n/pcmanfm.mo $ROOTFS/usr/share/locale/zh_CN/LC_MESSAGES/pcmanfm.mo

############# 输入法，安装拼音、五笔
chroot $ROOTFS apt-get install -y fcitx-pinyin fcitx-table-wubi fcitx-table-wbpy 

############# 锁屏界面提示必须依赖此库
chroot $ROOTFS apt-get install -y rxvt-unicode

chroot $ROOTFS apt-get clean

# 卸载软件相关工具
# software-properties-gtk 是软件安装、更新器，可以选择软件源、是否更新软件
# update-manager 是软件更新器，系统安装后，需要更新时，开机会自动弹出窗口
# synaptic是新立得软件管理器
chroot $ROOTFS apt-get autoremove -y synaptic lubuntu-software-center gdebi software-properties-gtk update-manager

rm -rf $ROOTFS/usr/bin/apt
rm -rf $ROOTFS/usr/bin/apt-get
rm -rf $ROOTFS/usr/bin/dpkg
rm -rf $ROOTFS/usr/bin/dpkg-deb

#chroot $ROOTFS rm -rf $(find /usr -name "*dpkg*") $(find /usr -name "*apt*")
#chroot $ROOTFS rm -rf $(find /etc -name "*dpkg*") $(find /etc -name "*apt*")
