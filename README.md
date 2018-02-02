# lubuntucd -- Customize Live CD for Lubuntu(16.04.3 64 bit)  

## document  
* [customize ](livecd_customize.md)  
* [soft install](softinstalling.md) 

## file(script)  
* 1_tar_iso.sh：unpack iso  
* 2_tar_splash.sh:unpack initrd and bootlogo  
* 3_build_splash.sh:make initrd and bootlogo  
* 4_build_iso.sh：make iso  
* update.sh：update logo and other files  
  
## Test  
test under vmware and U disk(using dd command to burn the iso)  
  
## Author  
Late Lee <li@latelee.org>  
  
## Donate  
[Donate the author](http://www.latelee.org/donate) <br>  
ETH: 0xe3725f50d7E79babae5F5390C85687bc75d0B5FC <br>  
ZEC: t1UUprgPWTeMy1AgmKkNpXXcUZPLL3cxv8U <br>  
  
# lubuntucd -- 定制Lubunt(16.04.3 64位) Live CD  

## 文档  
* [定制文档中文版](livecd_customize.md)  
* [软件安装文档中文版](softinstalling.md) 

## 需求项  
* 桌面背景图片 OK  
* 系统开机关机图片 OK  
* 开机文字、图片 OK  
* 终端效果 OK  
* 桌面图标及改名 OK  
* HOME目录放到桌面 OK  
* 主题、鼠标样式 OK （实现方法不是最佳的）  
* 时区修改 OK  
* 环境变量修改 OK  
* 系统汉化 OK  
* 拼音、五笔输入法 OK  
* 删除软件安装途径 OK  
* 软件安装 OK （过于复杂，另起文档描述）  
* 语言文件修改 OK  
* 锁屏 OK  
* 菜单分类、改名 OK  
* 桌面图标对齐 NOOOOO  
  
## 其它补充  
* 桌面图标 安装lubuntu 16.04 改名为 安装系统  
* 已经删除了软件中心、新立得、软件管理器  
* 卸载默认的firefox，安装firefox38版本（请自行下载压缩包）  
* 锁屏使用xlock（需要安装额外软件，还要修改链接库目录）  
* 语言包只针对英文、简体中文、繁体中文三种语言  
* 快速使用本工程脚本定制：./1_tar_iso.sh && ./2_tar_splash.sh && ./3_build_splash.sh && ./update.sh  && ./4_build_iso.sh   

## 文件说明  
* 1_tar_iso.sh：解压iso  
* 2_tar_splash.sh:解压initrd和bootlogo  
* 3_build_splash.sh:重新制作initrd和bootlogo  
* 4_build_iso.sh：制作iso  
* update.sh：更新配置文件、图片等。  
  
## 测试  
本工程制作的iso光盘镜像，使用vmware虚拟机启动测试；同时也使用dd烧写到U盘，在物理机上启动测试。  
  
## 作者  
李迟 <li@latelee.org>  
  
## 捐赠  
如果对阁下有帮助，欢迎捐赠。  
[捐赠作者](http://www.latelee.org/donate)  
数字币： <br>  
ETH: 0xe3725f50d7E79babae5F5390C85687bc75d0B5FC  
ZEC: t1UUprgPWTeMy1AgmKkNpXXcUZPLL3cxv8U  
  
  