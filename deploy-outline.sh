#!/bin/bash
# Outline VPN 一键部署脚本
# 适用于华为云中国区 Ubuntu/Debian 服务器

set -e

echo "=========================================="
echo "Outline VPN 服务器部署脚本"
echo "=========================================="

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then 
    echo "请使用 root 权限运行此脚本"
    echo "使用命令: sudo bash deploy-outline.sh"
    exit 1
fi

# 更新系统
echo "正在更新系统..."
apt-get update -y

# 安装 Docker
echo "正在安装 Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    systemctl enable docker
    systemctl start docker
    echo "Docker 安装完成"
else
    echo "Docker 已安装"
fi

# 部署 Outline Server
echo "正在部署 Outline Server..."
bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"

echo ""
echo "=========================================="
echo "部署完成！"
echo "=========================================="
echo ""
echo "请保存上面显示的连接信息（ss:// 开头的字符串）"
echo "在 iPhone 上："
echo "1. 下载 Outline 客户端（App Store 免费）"
echo "2. 打开 App，点击添加服务器"
echo "3. 粘贴连接信息或扫描二维码"
echo "4. 连接即可使用"
echo ""
