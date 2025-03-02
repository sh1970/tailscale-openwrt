#!/bin/sh

cleanup() {
    echo "已清除配置文件，正在查找残余文件，此步需要的时间较久，请耐心等待"
    cd /
    find . -type f -name "*tailscale*" -exec rm -f {} +
    find . -type d -name "*tailscale*" -exec rm -rf {} +
    echo "已清除，强烈推荐重启您的OpenWRT"
}

if [ -e /tmp/tailscaled ]; then
    echo "文件存在，停止Tailscale服务并执行清除操作"
    /etc/init.d/tailscale stop
    /tmp/tailscale down --accept-risk=lose-ssh
    /tmp/tailscale logout
    /etc/init.d/tailscale disable
    rm -rf /etc/tailscale*
    rm -rf /etc/config/tailscale*
    rm -rf /etc/init.d/tailscale*
    rm -rf /usr/bin/tailscale*
    rm -rf /tmp/tailscale*
    rm -rf /var/lib/tailscale*
    ip link delete tailscale0
    cleanup
else
    echo "文件不存在，直接执行清除操作"
    rm -rf /etc/tailscale*
    rm -rf /etc/config/tailscale*
    rm -rf /etc/init.d/tailscale*
    rm -rf /usr/bin/tailscale*
    rm -rf /tmp/tailscale*
    rm -rf /var/lib/tailscale*
    ip link delete tailscale0
    cleanup
fi

read -p "强烈推荐重启，请选择是否重启？(Y/N): " choice

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
    echo "正在重启..."
    reboot
elif [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
    echo "取消重启。"
else
    echo "无效的选项，取消重启。"
fi
