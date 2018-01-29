# lubuntucd -- Customize Live CD for Lubuntu(16.04.3 64 bit)

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
* 菜单分类、改名 NOOOOO
* 桌面图标对齐 NOOOOO
* 锁屏 NOOOOO
* 语言文件修改 NOOOOO

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
[捐赠作者](http://www.latelee.org/donate)<br>
数字币： <br>
ETH: 0xe3725f50d7E79babae5F5390C85687bc75d0B5FC <br>
ZEC: t1UUprgPWTeMy1AgmKkNpXXcUZPLL3cxv8U <br>

