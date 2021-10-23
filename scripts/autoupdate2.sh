#!/bin/sh --Created by DHDAXCW
opkg update
opkg install pv
opkg install gzip
cd /tmp
rm -rf artifact openwrt-rockchip*.img.gz openwrt-rockchip*img*
echo -e '\e[92m准备下载升级文件\e[0m'
for t in $(seq 0 14)
do {
    echo `(date -d "@$(( $(busybox date +%s) - 86400*$t))" +%Y.%m.%d)`
    wget https://github.com/DHDAXCW/NanoPi-R4S-2021/releases/download/$(date -d "@$(( $(busybox date +%s) - 86400*$t))" +%Y.%m.%d)-Lean2/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
    if [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz ]; then
        echo -e '\e[92m固件已下载\e[0m'
        echo `(date -d "@$(( $(busybox date +%s) - 86400*$t))" +%Y.%m.%d)`-Lean2
        while true
        do
            read -r -p "是否使用此固件? [Y/N] " input
            case $input in
                [yY][eE][sS]|[yY])
                    echo "已确认"
		            break 2;
		            ;;
		        [nN][oO]|[nN])
		            echo -e '\e[91m继续寻找前一天的固件\e[0m'
		            rm -rf artifact openwrt-rockchip*.img.gz openwrt-rockchip*img*
		            continue 2;
		            ;;
		       *)
		            echo "请输入[Y/N]进行确认"
		            ;;
		    esac
		 done 
	else
		echo -e '\e[91m当前固件不存在，继续寻找前一天的固件\e[0m'
	fi
}
done
if [ ! -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz ]; then
    echo -e '\e[91m没有可以使用的固件，脚本结束\e[0m'
    exit;
fi
echo -e '\e[92m准备解压固件\e[0m'
pv openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz | gunzip -dc > openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img
if [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img	]; then
	echo -e '\e[92m删除已下载文件\e[0m'
	rm -rf openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
fi
echo -e '\e[92m开始升级固件\e[0m'
sleep 3s
sysupgrade -v /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img
