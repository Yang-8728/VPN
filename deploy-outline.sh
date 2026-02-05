#!/bin/bash
# Outline VPN 一键部署脚本
# 适用于华为云中国区 Ubuntu/Debian 服务器

set -e

echo "=========================================="
echo "Outline VPN 服务器部署脚本"
echo "=========================================="

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then 
    echo "❌ 错误：需要 root 权限"
    echo "请使用命令: sudo bash deploy-outline.sh"
    exit 1
fi

# 更新系统
echo ""
echo "📦 正在更新系统..."
apt-get update -y

# 安装 Docker
echo ""
echo "🐳 正在安装 Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    systemctl enable docker
    systemctl start docker
    echo "✅ Docker 安装完成"
else
    echo "✅ Docker 已安装"
fi

# 部署 Outline Server
echo ""
echo "🚀 正在部署 Outline Server..."
echo "（这可能需要几分钟，请耐心等待...）"
echo ""

# 运行 Outline 安装脚本并保存输出
INSTALL_OUTPUT=$(bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)" 2>&1)

echo "$INSTALL_OUTPUT"

# 提取访问密钥
ACCESS_KEY=$(echo "$INSTALL_OUTPUT" | grep -o 'ss://[^"]*' | head -1)

echo ""
echo "=========================================="
echo "✅ 部署完成！"
echo "=========================================="
echo ""

if [ -n "$ACCESS_KEY" ]; then
    echo "🔑 您的访问密钥（请复制保存）："
    echo ""
    echo "    $ACCESS_KEY"
    echo ""
    echo "⚠️  重要：请立即保存这个密钥！"
else
    echo "⚠️  未能自动提取访问密钥，请从上面的输出中查找 ss:// 开头的字符串"
fi

echo ""
echo "📱 下一步操作："
echo "1. 在 iPhone 的 App Store 搜索并下载 'Outline'（免费）"
echo "2. 打开 Outline App，点击 '+' 添加服务器"
echo "3. 粘贴上面的访问密钥（ss:// 开头的字符串）"
echo "4. 点击连接，即可使用"
echo ""
echo "💡 验证连接："
echo "   连接后访问 https://ip.sb 应该显示中国 IP 地址"
echo ""
