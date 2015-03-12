openwrt-xiaomi-mini
==============

OpenWrt Patch for Xiaomi Router Mini

#### 固件编译方法

    git clone https://github.com/rssnsj/openwrt-xiaomi-mini.git
    cd openwrt-xiaomi-mini
    make

#### 刷机方法

* 首次刷机，开启小米路由的SSH权限（ https://d.miwifi.com/rom/ssh ），并登录，使用命令：

    `mtd -r write openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin firmware`

* 以后每次刷机使用：

    `sysupgrade openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin`
