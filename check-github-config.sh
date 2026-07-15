#!/bin/bash
# GitHub 配置验证和修复脚本

echo "========================================"
echo "GitHub 配置检查脚本"
echo "========================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查函数
check_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "1. 检查 Git 配置..."
echo "------------------------"

# 检查用户名
USER_NAME=$(git config --global user.name 2>/dev/null)
if [ -n "$USER_NAME" ]; then
    check_pass "用户名: $USER_NAME"
else
    check_fail "用户名未配置"
fi

# 检查邮箱
USER_EMAIL=$(git config --global user.email 2>/dev/null)
if [ -n "$USER_EMAIL" ]; then
    check_pass "邮箱: $USER_EMAIL"
else
    check_fail "邮箱未配置"
fi

# 检查凭证助手
CRED_HELPER=$(git config --global credential.helper 2>/dev/null)
if [ -n "$CRED_HELPER" ]; then
    check_pass "凭证助手: $CRED_HELPER"
else
    check_warn "凭证助手未配置，将使用默认设置"
    git config --global credential.helper osxkeychain
fi

echo ""
echo "2. 检查 SSH 配置..."
echo "------------------------"

# 检查 SSH 密钥
if [ -f ~/.ssh/id_rsa ]; then
    check_pass "SSH 私钥存在: ~/.ssh/id_rsa"
else
    check_warn "SSH 私钥不存在"
fi

# 检查 SSH 公钥
if [ -f ~/.ssh/id_rsa.pub ]; then
    check_pass "SSH 公钥存在: ~/.ssh/id_rsa.pub"
    echo "   公钥内容:"
    cat ~/.ssh/id_rsa.pub | sed 's/^/   /'
else
    check_warn "SSH 公钥不存在"
fi

echo ""
echo "3. 检查远程仓库..."
echo "------------------------"

# 检查远程仓库
REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null)
if [ -n "$REMOTE_URL" ]; then
    check_pass "远程仓库: $REMOTE_URL"
else
    check_fail "远程仓库未配置"
fi

echo ""
echo "4. 检查仓库状态..."
echo "------------------------"

# 检查分支
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
if [ -n "$CURRENT_BRANCH" ]; then
    check_pass "当前分支: $CURRENT_BRANCH"
else
    check_fail "无法确定当前分支"
fi

# 检查与远程的差异
AHEAD=$(git rev-list --count HEAD ^origin/$CURRENT_BRANCH 2>/dev/null)
BEHIND=$(git rev-list --count origin/$CURRENT_BRANCH ^HEAD 2>/dev/null)

if [ "$AHEAD" -gt 0 ] 2>/dev/null; then
    check_warn "本地领先远程 $AHEAD 个提交"
fi

if [ "$BEHIND" -gt 0 ] 2>/dev/null; then
    check_warn "本地落后远程 $BEHIND 个提交，建议先拉取更新"
fi

echo ""
echo "5. 检查 Obsidian Git 插件..."
echo "------------------------"

PLUGIN_DIR="$HOME/Documents/traeProject/obsidianPro/myOb/.obsidian/plugins/obsidian-git"
if [ -d "$PLUGIN_DIR" ]; then
    check_pass "Git 插件已安装"
    if [ -f "$PLUGIN_DIR/main.js" ]; then
        VERSION=$(grep -o '"version": *"[^"]*"' "$PLUGIN_DIR/manifest.json" | cut -d'"' -f4)
        check_pass "插件版本: $VERSION"
    fi
else
    check_fail "Git 插件未找到"
fi

echo ""
echo "========================================"
echo "配置检查完成"
echo "========================================"
echo ""
echo "下一步操作："
echo "1. 如果 SSH 公钥已生成，请添加到 GitHub:"
echo "   https://github.com/settings/keys"
echo ""
echo "2. 切换到 SSH 方式（推荐）："
echo "   git remote set-url origin git@github.com:whlmpower/myOb.git"
echo ""
echo "3. 测试连接："
echo "   ssh -T git@github.com"
echo ""
echo "4. 推送代码："
echo "   git push origin main"
echo ""
