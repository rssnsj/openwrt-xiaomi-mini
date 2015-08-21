openwrt-xiaomi-mini
==============

OpenWrt Patch for Xiaomi Router Mini

-------

#### OpenWrt补丁及ImageBuilder说明
* 包含了小米路由mini机型的OpenWrt补丁；
* 可以Checkout下来代码直接make，会自动打补丁、自动载入menuconfig配置，并自动编译；
* 也可以直接利用ImageBuilder，将机型支持代码（dts描述文件），与OpenWrt官方二进制程序合并成相应机型的固件。

#### 固件包含的功能
* 基于 OpenWrt Barrier Breaker - r43770 版本；
* 自带5G Wi-Fi驱动；
* 内置基于IP地址、域名列表的透明代理服务（SS），及其LuCi配置界面；
* 内置基于IP地址、域名列表的非标准VPN服务（minivtun），及其LuCI配置界面；
* 内置“文件中转站”功能，自动挂载USB存储以及自动配置Samba服务。

#### 编译好的固件下载
* 请在本项目的Releases下载，或者 http://rssn.cn/roms/ 。

#### 前提工作

    # 安装必需的软件包（仅限Ubuntu/Debian）
    sudo apt-get install build-essential git subversion wget flex gettext libncurses5-dev unzip gawk liblzma-dev zlib1g-dev ccache u-boot-tools
      
    # Checkout项目代码
    git clone https://github.com/rssnsj/openwrt-xiaomi-mini.git

#### 固件生成方法1 - 编译

    cd openwrt-xiaomi-mini
    make
    # 编译成功后，固件文件位于: openwrt-ramips/bin/openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin

#### 固件生成方法2 - 利用ImageBuilder将机型支持代码与OpenWrt官方二进制程序合并生成固件

    cd openwrt-xiaomi-mini/ImageBuilder
      
    # 解压ImageBuilder和SDK（事先从downloads.openwrt.org下载好）
    tar jxvf xxx/OpenWrt-ImageBuilder-ramips_mt7620a-for-linux-x86_64.tar.bz2
    tar jxvf xxx/OpenWrt-SDK-ramips-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
      
    # 生成固件：
    make FEEDS=1 RALINK=1
    # FEEDS=1 表示包含项目 rssnsj/network-feeds 的功能在内
    # RALINK=1 表示包含5G驱动在固件中

#### 刷机方法

* 首次刷机，开启小米路由的SSH权限（ https://d.miwifi.com/rom/ssh ），并登录，使用命令：

    `mtd -r write openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin firmware`

* 以后每次刷机使用：

    `sysupgrade openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin`

#### 说明
* 编译时若碰到代码包下载失败，或下载过于缓慢，请先 Ctrl + C 暂停，手动下载同名的文件放到 openwrt-ramips/dl 下面，再执行“make”继续编译。
