openwrt-xiaomi-mini
==============

OpenWrt Patch for Xiaomi Router Mini

#### 固件编译方法

    git clone https://github.com/rssnsj/openwrt-xiaomi-mini.git
    cd openwrt-xiaomi-mini
    make

#### 刷机方法

    mtd -r write openwrt-ramips-mt7620a-xiaomi-miwifi-mini-squashfs-sysupgrade.bin firmware
