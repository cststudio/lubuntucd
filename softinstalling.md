<center><h1>Lubuntu16.4.3定制教程</h1></center>  
<center>迟思堂工作室 李迟(li@latelee.org)</center>  
  
# 0、前言  
  
本文介绍lubunut的软件安装过程，先以简单例子介绍各种安装方法，然后再结合实际的例子进行演示。本文使用lubuntu16.04和ubuntu16.04进行实测验证。本文命令应该适用所有基于ubuntu系统。不管是用chroots进入squashfs-root目录，还是在物理机上。  
安装软件有很多种方式。  
首推是apt-get install，十分简单易用，安装、卸载都简单。用法示例如下：  

```
apt-get install xxx  
apt-get remove xxx  
```
其次是deb包，应安装和卸载命令如下：  
```
dpkg -i xxx.deb  
dpkg -r xxx.deb  
```
第三是二进制文件解压，适用于小软件、小工具（因为只有一个二进制，不依赖其它库，解压到/bin/或/usr/bin即可直接运行），示例此处从略。  
最后是源码编译，适用于任何找到源码的软件，缺点是麻烦，不管是安装还是卸载。  
  
# 1、简单直接方式：apt-get install  
ubuntu强烈推荐使用apt-get方法来安装软件。  
以安装vim为例。  
```  
# 保证可联网  
cp /etc/resolv.conf squashfs-root/etc/resolv.conf  
# ping测试  
ping www.baidu.com -c 3  
#更新源  
apt-get update  
# 安装vim  
apt-get install vim  
```  
如果要卸载，命令也十分简单：  
```  
# 卸载vim  
# apt-get remove vim  
```  
注意，apt-get命令执行时，可能会停留让用户选择“Y/n”，输入y即可，当然也可能不会提示。如果十分确定要安装/卸载软件，则可以在apt-get install/remove后添加-y。如：  
```
apt-get install -y vim  
apt-get remove -y vim  
```  
此方式默认使用ubuntu源上的软件版本，可能是最新版本（因为ubuntu源不断在更新），也可能不是最新版本（比如，截至文稿编写时间，gcc最新版本是7.2，而ubuntu为5.4）。  
  
  
# 2、deb包安装  
ubuntu系统可以使用deb进行安装，有些软件提供deb下载的话，则可以选择此种方式安装。安装命令如下：  
```
dpkg -i gattlib_dbus_0.2-dev_x86_64.deb  
```
删除命令如下：  
```
dpkg -r gattlib_dbus_0.2-dev_x86_64.deb  
```  
  
# 3、源码安装  
源码安装适用于所有软件的安装（提供源码的情况下），一般由三个步骤（“三步曲”）完成：  
1、配置以及生成Makefile(有些软件提供自编写的Makefile，则此步无须进行)  
```
./configure  
```
2、编译  
```
make  
```
3、安装  
```
make install  
```
默认安装到系统目录（如/usr/local/bin），可以在configure时候添加--prefix来指定要安装的目录。注意说明的是，configure是最麻烦的一个步骤，它涉及到交叉编译、目录指定等等工作。  
  
## 3.1 automake安装示例  
下面是automake安装过程：  
1、下载：automake-1.13.4.tar.gz (地址：http://ftp.gnu.org/gnu/automake/)  
2、解压文件  
```
tar zxvf automake-1.13.4.tar.gz  
```
3、进入解压后的目录：  
```
cd automake-1.13.4  
```
4、执行“三步曲”  
```
./configure && make && make install  
```  
完成。  
  
## 3.2 alsa  和alsa-utils安装示例  
下面对alsa编译过程进行演示（注意：一些配置是alsa特定的，其它软件不一定有）。  
下载alsa库：  
ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.4.1.tar.bz2  
配置（注：是arm平台的编译）  
```
./configure --prefix=/usr/local/alsa  --disable-python --host=arm-linux  
```
编译、安装：  
```
make && make install  
```  
下载地址alsa-utils压缩包：  
ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.1.4.tar.bz2  
配置（注：需要使用前面编译的alsa库，而且指定安装目录为/home/latelee/bin/alsa-utils。）  
```
./configure --prefix=/home/latelee/bin/alsa-utils --with-alsa-prefix=/usr/local/alsa/lib/ --with-alsa-inc-prefix=/usr/local/alsa/in  
```  
  
# 4、实例演示  
## 4.1 安装firefox38  
下载：  
http://releases.mozilla.org/pub/firefox/releases/38.0/  
中文版本：  
http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/  
具体地址：  
http://releases.mozilla.org/pub/firefox/releases/38.0/linux-x86_64/zh-CN/firefox-38.0.tar.bz2  
源码地址：  
http://releases.mozilla.org/pub/firefox/releases/38.0/source/  
（源码编译太耗时，不建议这样做）  
本节在iso目录进行。  
  
1、备份配置文件（菜单图标快捷方式文件）  
```
cp squashfs-root/usr/share/lintian/overrides/firefox work/firefox  
cp squashfs-root/usr/share/applications/firefox.desktop work/firefox  
```  
2、安装38版本的firefox。  
将firefox-38.0.tar.bz2文件拷贝到squashfs-root目录。然后使用chroot进入squashfs-root目录。  
卸载原来已经安装的firefox：  
```
apt-get remove firefox  
```
将firefox-38.0.tar.bz2解压，移动到/opt目录，改名为firefox38。  
```
tar xjf firefox-38.0.tar.bz2  
mv firefox /opt/firefox38  
rm firefox-38.0.tar.bz2 # 删除压缩文件  
```
创建链接文件/usr/bin/firefox：  
```
ln -s /opt/firefox38/firefox /usr/bin/firefox  
```  
注意，如果重新制作ISO，启动系统，只能在命令行中输入firefox来启动，而不能从菜单中找到对应的图标。这是因为在apt-get remove firefox时，将图标文件也删除了。  
  
3、恢复图标文件  
退出chroot环境，执行以下命令：  
```
cp work/firefox/firefox squashfs-root/usr/share/lintian/overrides/firefox  
cp work/firefox/firefox.desktop squashfs-root/usr/share/applications/firefox.desktop  
```  
此时，重新制作ISO并启动，在菜单点击firefox图标，就能启动38版本的firefox了。  
