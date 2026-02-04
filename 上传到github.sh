#!/bin/bash
# 一键上传到GitHub脚本

echo "开始上传到GitHub..."

# 初始化git仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "初始提交：Outline VPN部署项目"

# 创建GitHub仓库（需要先安装gh命令行工具）
# 如果没有安装gh，请访问：https://cli.github.com/
echo ""
echo "请选择操作："
echo "1. 如果你已经有GitHub仓库，输入仓库地址（例如：https://github.com/你的用户名/仓库名.git）"
echo "2. 如果要创建新仓库，请先在GitHub网站上创建，然后输入地址"
echo ""
read -p "请输入GitHub仓库地址: " repo_url

# 添加远程仓库
git remote add origin "$repo_url"

# 推送到GitHub
git branch -M main
git push -u origin main

echo ""
echo "上传完成！"
echo "仓库地址：$repo_url"
