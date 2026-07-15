#!/bin/bash
# GitHub 认证配置脚本
# 用于配置 Obsidian Git 插件的 HTTPS + Token 认证

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}GitHub 认证配置脚本${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 检查是否在 Git 仓库中
if [ ! -d ".git" ]; then
    echo -e "${RED}错误: 当前目录不是 Git 仓库${NC}"
    exit 1
fi

# 显示当前配置
echo -e "${YELLOW}当前配置:${NC}"
echo "  用户名: $(git config --global user.name 2>/dev/null || echo '未设置')"
echo "  邮箱: $(git config --global user.email 2>/dev/null || echo '未设置')"
echo "  远程仓库: $(git config --get remote.origin.url 2>/dev/null || echo '未设置')"
echo ""

# 配置凭证助手
echo -e "${YELLOW}[1/3] 配置 Git 凭证助手...${NC}"
git config --global credential.helper osxkeychain
echo -e "${GREEN}✓ 凭证助手已配置: osxkeychain${NC}"
echo ""

# 说明 Token 获取方式
echo -e "${YELLOW}[2/3] 获取 GitHub Personal Access Token${NC}"
echo ""
echo -e "${BLUE}请按以下步骤操作:${NC}"
echo ""
echo "1. 打开浏览器访问:"
echo -e "   ${GREEN}https://github.com/settings/tokens/new${NC}"
echo ""
echo "2. 填写 Token 信息:"
echo "   - Note: Obsidian Git"
echo "   - Expiration: 90 days"
echo "   - Scopes: 勾选 ✅ repo"
echo ""
echo "3. 点击 Generate token"
echo ""
echo "4. 复制生成的 Token（⚠️ 只显示一次！）"
echo ""

# 提示用户输入 Token
echo -e "${YELLOW}[3/3] 配置 Git 凭据${NC}"
echo ""
echo -e "${BLUE}请输入 GitHub 凭据:${NC}"
echo ""

# 使用 git credential 交互式输入
echo "protocol=https" | git credential fill <<EOF
host=github.com
username=whlmpower
EOF

echo ""
echo -e "${GREEN}✓ 凭据配置完成！${NC}"
echo ""

# 测试推送
echo -e "${YELLOW}测试推送...${NC}"
if git push origin main 2>&1; then
    echo ""
    echo -e "${GREEN}✓ 推送成功！${NC}"
    echo ""
    echo -e "${BLUE}Obsidian Git 插件现在可以正常工作了！${NC}"
    echo ""
    echo "在 Obsidian 中使用:"
    echo "  1. 命令面板 (Cmd/Ctrl + P)"
    echo "  2. 搜索 Git: Push"
    echo "  3. 点击推送"
else
    echo ""
    echo -e "${RED}✗ 推送失败，请检查 Token 是否正确${NC}"
    echo ""
    echo "如 Token 错误，请重新配置:"
    echo "  git credential-osxkeychain erase <<EOF"
    echo "  protocol=https"
    echo "  host=github.com"
    echo "  EOF"
fi

echo ""
echo -e "${BLUE}========================================${NC}"
