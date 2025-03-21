#!/bin/bash
# ================================================
# 脚本名称: 系统信息查询脚本
# 描述: 该脚本用于查询系统的基本信息，包括CPU、内存、磁盘等。
# 版本: 1.0
# 作者: DHDAXCW
# ================================================

echo "=== 系统信息 ==="
# CPU 信息（中文）
echo -e "\n=== CPU 信息 ==="
echo -e "CPU 总核心数: $(nproc)"
echo "CPU 详细信息:"
if [ -f /proc/cpuinfo ]; then
  echo "型号名称: $(grep 'model name' /proc/cpuinfo | head -n1 | cut -d':' -f2 | sed 's/^\s*//')"
  echo "当前频率: $(grep 'cpu MHz' /proc/cpuinfo | head -n1 | cut -d':' -f2 | sed 's/^\s*//') MHz"
  echo "缓存大小: $(grep 'cache size' /proc/cpuinfo | head -n1 | cut -d':' -f2 | sed 's/^\s*//')"
  echo "架构类型: $(lscpu | grep 'Architecture' | cut -d':' -f2 | sed 's/^\s*//')"
  echo "每插槽核心数: $(lscpu | grep 'Core(s) per socket' | cut -d':' -f2 | sed 's/^\s*//')"
  echo "每核心线程数: $(lscpu | grep 'Thread(s) per core' | cut -d':' -f2 | sed 's/^\s*//')"
      
  # 最大频率和最小频率
  MAX_FREQ=$(lscpu | grep -E 'CPU max MHz|CPU MHz max' | cut -d':' -f2 | sed 's/^\s*//')
  MIN_FREQ=$(lscpu | grep -E 'CPU min MHz|CPU MHz min' | cut -d':' -f2 | sed 's/^\s*//')
  echo "最大频率: ${MAX_FREQ:-未知} MHz"
  echo "最小频率: ${MIN_FREQ:-未知} MHz"
else
  echo "CPU 信息不可用（/proc/cpuinfo 文件缺失）"
fi

# 内存信息
echo -e "\n=== Memory Information ==="
free -h | awk '/^Mem:/ {print "Total Memory\t: " $2 "\nUsed Memory\t: " $3 "\nFree Memory\t: " $4}'

# 磁盘信息
echo -e "\n=== Disk Information ==="
df -h | grep -E '^/dev/' | awk '{print "Device: " $1 "\tSize: " $2 "\tUsed: " $3 "\tAvail: " $4 "\tMount: " $6}'

# 网卡信息
echo -e "\n=== 网卡信息 ==="
if command -v ethtool >/dev/null 2>&1; then
  for iface in $(ip -br addr show | awk '{print $1}' | grep -v '^lo$'); do
    echo "接口名称: $iface"
    echo "状态\t: $(ip -br addr show | grep "^$iface" | awk '{print $2}')"
    echo "IP 地址\t: $(ip -br addr show | grep "^$iface" | awk '{print $3}')"
    echo "速率\t: $(ethtool "$iface" 2>/dev/null | grep 'Speed:' | awk '{print $2}' || echo '未知')"
    echo "----------------"
  done
else
  echo "ethtool 未安装，仅显示基本网卡信息"
  ip -br addr show | awk '{print "接口: " $1 "\t状态: " $2 "\tIP: " $3}'
fi

#echo -e "\n=== 网络速度测试 ==="
#if command -v speedtest-cli >/dev/null 2>&1; then
#  echo "正在测试网络速度，请稍候..."
#  speedtest-cli --simple
#else
#  echo "未找到 speedtest-cli，请确保已安装。"
#fi

# 其他系统详情
echo -e "\n=== Additional System Details ==="
uname -a
[ -f /proc/version ] && echo "版本信息:" && cat /proc/version
[ -f /etc/issue.net ] && echo "发行版 (net):" && cat /etc/issue.net
[ -f /etc/issue ] && echo "发行版:" && cat /etc/issue
echo -e "\n资源限制:"
ulimit -a
