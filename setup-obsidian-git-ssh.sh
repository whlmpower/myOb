#!/bin/bash
# Obsidian Git SSH 配置脚本

echo "========================================"
echo "Obsidian Git SSH 配置"
echo "========================================"
echo ""

cd "$(dirname "$0")" || exit 1

# 检查是否在 Git 仓库中
if [ ! -d ".git" ]; then
    echo "错误: 当前目录不是 Git 仓库"
    exit 1
fi

echo "当前状态:"
echo "  用户名: $(git config --global user.name)"
echo "  邮箱: $(git config --global user.email)"
echo ""

# 切换到 SSH 方式
echo "[1/3] 切换远程仓库到 SSH 方式..."
git remote set-url origin git@github.com:whlmpower/myOb.git
echo "✓ 已切换到 SSH"
echo "  新地址: $(git config --get remote.origin.url)"
echo ""

# 配置 Obsidian Git 插件
echo "[2/3] 配置 Obsidian Git 插件..."

# 备份原配置
if [ -f ".obsidian/plugins/obsidian-git/data.json" ]; then
    cp ".obsidian/plugins/obsidian-git/data.json" ".obsidian/plugins/obsidian-git/data.json.bak"
    echo "✓ 原配置已备份"
fi

# 更新插件配置
PLUGIN_CONFIG=".obsidian/plugins/obsidian-git/data.json"
if [ -f "$PLUGIN_CONFIG" ]; then
    # 使用 jq 更新配置（如果可用）
    if command -v jq &> /dev/null; then
        jq '. + {"gitDir": "~/.ssh", "sshKeyPath": "~/.ssh/id_rsa"}' "$PLUGIN_CONFIG" > "$PLUGIN_CONFIG.tmp"
        mv "$PLUGIN_CONFIG.tmp" "$PLUGIN_CONFIG"
        echo "✓ SSH 配置已更新"
    else
        echo "⚠ jq 未安装，手动检查插件配置"
    fi
fi

echo ""

# 测试 SSH 连接
echo "[3/3] 测试 SSH 连接..."
if ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 git@github.com echo "SSH connected" 2>&1; then
    echo "✓ SSH 连接正常"
else
    echo "⚠ SSH 连接测试失败，但可能仍可工作"
fi

echo ""
echo "========================================"
echo "配置完成"
echo "========================================"
echo ""
echo "下一步:"
echo "1. 重启 Obsidian"
echo "2. 在 Obsidian 中使用 Git: Push"
echo ""
echo "如仍有问题，请检查:"
echo "  - ~/.ssh/id_rsa 私钥权限"
echo "  - GitHub 设置中的 SSH 公钥"
echo "  chmod 600 ~/.ssh/id_rsa"
echo ""
