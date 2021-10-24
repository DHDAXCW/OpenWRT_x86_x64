# x86-x64 每天自动更新插件和内核版本。
## 👉使用本固件前，请严格遵守国家互联网使用相关法律规定,不要违反国家法律规定！👈
### 默认编译  
- 用户名：root 密码：password  管理IP：192.168.2.1
- 固件下载地址：https://github.com/DHDAXCW/FusionWRT_x86_x64/releases
- 固件格式 openwrt-x86-64-generic-squashfs-combined-efi.img.gz  # 看准了！
### - Docker：正式版带docker，有超频，带有docker插件。（对passwall的udp要求很高，不要刷docker版本）
- 电报群：https://t.me/DHDAXCW
# 插件展示
 ![Alt text](scripts/20.png?raw=true "Title")


- 正式版（含超频）对折腾的，可以选择，电压一定要考虑。超频都是升压的，会造成不稳定的。比如跑cpu测试容易升压等。
- Docker版 含Docker插件，会导致udp转发失效 慎用哦，只要别开passwall的udp，啥都不影响使用！
- 稳定版 含有日常使用插件

# 在线升级
ttyd执行：
```
https://raw.githubusercontent.com/DHDAXCW/FusionWRT_x86_x64/main/scripts/autoupdate.sh && sh autoupdate.sh
```
## 提示
 - 我的固件加了动态超频，不管热不热这是取决后台运行程序在跑什么。
 - 感觉很热  就加风扇，推荐 风扇6cm×6cm，薄1cm，usb也行 或者端子线zh1.5（风扇脚本目前在建设中）
# [赏个鸡腿吧](https://afdian.net/@dhdaxcw/plan)
### https://afdian.net/@dhdaxcw/plan
## 鸣谢

特别感谢以下项目：

Openwrt 官方项目：

<https://github.com/openwrt/openwrt>

Lean 大的 Openwrt 项目：

<https://github.com/coolsnowwolf/lede>

immortalwrt 的 OpenWrt 项目：

<https://github.com/immortalwrt/immortalwrt>

P3TERX 大佬的 Actions-OpenWrt 项目：

<https://github.com/P3TERX/Actions-OpenWrt>
