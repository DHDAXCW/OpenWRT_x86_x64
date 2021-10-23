#---Edit by DHDAXCW@lone_wind
#检查更新
check_update () {
    #wget 'https://git.openwrt.org/?p=keyring.git;a=blob_plain;f=usign/1035ac73cc4e59e3' -O 1035ac73cc4e59e3
    #opkg-key add 1035ac73cc4e59e3
    opkg update && opkg install gzip
}
#清理文件
clean_up() {
    rm -rf artifact openwrt-rockchip*.img.gz openwrt-rockchip*img* sha256sums* autoupdate.sh*
}
#版本选择
version_choose () {
    echo -e '\e[92m输入对应数字选择版本或退出\e[0m'
    echo "0---Exit退出"
    echo "1---Docker_高大全"
    echo "2---Stable_稳定精简"
    echo "3---Formal_正式版"
    read -p "请输入数字[0-3],回车确认 " choose
    case $choose in
        0)
            echo -e '\e[91m退出脚本，升级结束\e[0m'
            exit;
            ;;
        1)
            echo -e '\e[92m已选择Docker_高大全\e[0m'
            ;;
        2)
            echo -e '\e[92m已选择Stable_稳定精简\e[0m'
            ;;
        3)
            echo -e '\e[92m已选择Formal_正式版\e[0m'
            ;;
        *)
            echo -e '\e[91m非法输入,请输入数字[0-3]\e[0m'
            version_choose
            ;;
    esac
}
#固件下载
download_file () {
    cd /tmp && clean_up
    days=$(($days+1))
    echo `(date -d "@$(($(busybox date +%s) - 86400*($days-1)))" +%Y.%m.%d)`
    wget https://github.com/DHDAXCW/NanoPi-R4S-2021/releases/download/$(date -d "@$(($(busybox date +%s) - 86400*($days-1)))" +%Y.%m.%d)-Lean$choose/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
    wget https://github.com/DHDAXCW/NanoPi-R4S-2021/releases/download/$(date -d "@$(($(busybox date +%s) - 86400*($days-1)))" +%Y.%m.%d)-Lean$choose/sha256sums
    exist_judge
}
#存在判断
exist_judge () {
    if [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz ]; then
        echo -e '\e[92m固件已下载\e[0m'
        echo `(date -d "@$(($(busybox date +%s) - 86400*($days-1)))" +%Y.%m.%d)`-Lean$choose
        version_skip
    elif [ $days == 21 ]; then
        echo -e '\e[91m未找到合适固件，脚本退出\e[0m'
        exit;
    else
        echo -e '\e[91m当前固件不存在，寻找前一天的固件\e[0m'
        download_file
    fi
}
#跳过固件
version_skip () {
    read -r -p "是否使用此固件? [Y/N]确认 [E]退出 " skip
    case $skip in
        [yY][eE][sS]|[yY])
            echo "已确认"
            ;;
        [nN][oO]|[nN])
            echo -e '\e[91m寻找前一天的固件\e[0m'
            download_file
            ;;
        [eE][xX][iI][tT]|[eE])
            echo -e '\e[91m取消固件下载，退出升级\e[0m'
            clean_up
            exit;
            ;;
        *)
            echo -e '\e[91m请输入[Y/N]进行确认，输入[E]退出\e[0m'
            version_skip
            ;;
    esac
}
#固件验证
firmware_check () {
    if [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img	]; then
        echo -e '\e[92m检查升级文件大小\e[0m'
        du -h /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img
    elif [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz	]; then
        echo -e '\e[92m计算固件的sha256sum值\e[0m'
        sha256sum openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
        echo -e '\e[92m对比下列sha256sum值，检查固件是否完整\e[0m'
        grep ext4-sysupgrade sha256sums
    else
        echo -e '\e[91m没有相关升级文件，请检查网络\e[0m'
        clean_up
        exit;
    fi
    version_confirm
}
#版本确认
version_confirm () {
    read -p "是否确认升级? [Y/N] " confirm
    case $confirm in
        [yY][eE][sS]|[yY])
            echo -e '\e[92m已确认升级\e[0m'
            ;;
        [nN][oO]|[nN])
            echo -e '\e[91m已确认退出\e[0m'
            clean_up
            exit;
            ;;
        *)
            echo -e '\e[91m请输入[Y/N]进行确认\e[0m'
            version_confirm
            ;;
    esac
}
#解压固件
unzip_fireware () {
    rm -rf /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img
    echo -e '\e[92m开始解压固件\e[0m'
    gunzip /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz
    if [ -f /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img	]; then
        echo -e '\e[92m已解压出升级文件\e[0m'
        firmware_check
    else
        echo -e '\e[91m解压固件失败\e[0m'
        clean up;
        exit;
        #unzip_fireware
    fi
}
#升级系统
update_system () {
    echo -e '\e[92m开始升级系统\e[0m'
    sleep 3s
    sysupgrade -v /tmp/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img
}
#系统更新
update_firmware () {
    check_update    #检查更新
    clean_up        #清理文件
    version_choose  #版本选择
    download_file   #固件下载
    firmware_check  #固件验证
    unzip_fireware  #解压固件
    update_system   #升级系统
}

update_firmware
