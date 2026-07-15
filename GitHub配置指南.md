# GitHub 账号配置指南

## ✅ 当前配置状态

### Git 配置
- **用户名**: `whlmpower`
- **邮箱**: `whl9895@163.com`
- **凭证助手**: `osxkeychain` (macOS 钥匙串)
- **远程仓库**: `https://github.com/whlmpower/myOb.git`

### Obsidian Git 插件
- **插件**: `obsidian-git` v2.38.5
- **状态**: 已安装并启用

### SSH 密钥
- **公钥位置**: `~/.ssh/id_rsa.pub`
- **密钥已添加到 ssh-agent**: ✅
- **GitHub 连接测试**: ⚠️ 网络延迟高（255ms+），可能连接超时

---

## 🔧 解决方案

### 方案一：SSH 方式（推荐）

SSH 方式更安全，不需要每次输入密码。

#### 步骤 1：添加 SSH 公钥到 GitHub

1. 复制你的 SSH 公钥：
   ```bash
   cat ~/.ssh/id_rsa.pub
   ```

2. 打开 GitHub → Settings → SSH and GPG keys → New SSH key

3. 粘贴公钥内容，保存

4. 测试连接：
   ```bash
   ssh -T git@github.com
   ```

5. 将远程仓库改为 SSH 方式：
   ```bash
   git remote set-url origin git@github.com:whlmpower/myOb.git
   ```

#### 步骤 2：配置 Obsidian Git 插件

插件已配置完成，无需额外设置。

---

### 方案二：HTTPS + Personal Access Token

如果 SSH 方式不可行，可以使用 HTTPS 配合 GitHub Token。

#### 步骤 1：创建 GitHub Personal Access Token

1. 打开 GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)

2. 生成新 Token，勾选权限：
   - ✅ `repo` (Full control of private repositories)

3. 复制生成的 Token（只显示一次！）

#### 步骤 2：配置 Git 凭据

```bash
git config --global credential.helper osxkeychain
git config --global credential.helper store
```

然后执行一次 git push，系统会提示输入：
- **Username**: `whlmpower`
- **Password**: 粘贴你的 GitHub Token

#### 步骤 3：验证配置

```bash
git push origin main
```

---

## 🚀 快速测试

配置完成后，在终端测试：

```bash
cd /Users/whl/Documents/traeProject/obsidianPro/myOb
git status
git push origin main
```

## 📝 Obsidian Git 插件使用

配置完成后，在 Obsidian 中：

1. 打开命令面板（`Cmd/Ctrl + P`）
2. 搜索 `Git` 相关命令
3. 常用命令：
   - `Git: Commit all changes`
   - `Git: Push`
   - `Git: Pull`
   - `Git: Sync`（Commit + Push）

---

## ⚠️ 常见问题

### 问题：推送超时或失败

**原因**：网络延迟高或 GitHub 连接不稳定

**解决**：
1. 检查网络连接：`ping github.com`
2. 尝试使用 SSH 方式
3. 配置 Git 代理（如需要）

### 问题：权限被拒绝

**原因**：SSH 密钥未添加到 GitHub 或 Token 权限不足

**解决**：
1. SSH：确认公钥已添加到 GitHub
2. HTTPS：确认 Token 有 `repo` 权限

### 问题：Obsidian 插件无响应

**解决**：
1. 重启 Obsidian
2. 检查插件是否启用：Settings → Community plugins → Git
3. 查看控制台错误：Help → Toggle developer tools

---

## 📞 获取帮助

- GitHub 文档：https://docs.github.com/en/authentication
- Obsidian Git 插件：https://github.com/denolehov/obsidian-git
