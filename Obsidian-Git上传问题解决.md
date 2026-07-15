# Obsidian Git 插件上传问题解决方案

## 🔍 问题分析

**根本原因**: GitHub 已不支持密码登录，必须使用 **Personal Access Token (PAT)**

**当前状态**:
- ✅ SSH 公钥已添加到 GitHub（你提到"已存在"）
- ✅ Git 配置正确（用户名、邮箱）
- ❌ Obsidian Git 插件使用 HTTPS 方式推送
- ❌ 未配置 Personal Access Token

---

## 🎯 推荐方案：配置 HTTPS + Personal Access Token

### 步骤 1: 创建 GitHub Personal Access Token

1. **打开 GitHub Token 页面**:
   ```
   https://github.com/settings/tokens/new
   ```

2. **填写 Token 信息**:
   - **Note**: `Obsidian Git`（或任意名称）
   - **Expiration**: 90 days（或自定义）
   - **Scopes**: 勾选 ✅ `repo`（完整仓库访问）

3. **点击 Generate token**

4. **复制 Token**（⚠️ 只显示一次！）:
   ```
   <SECRET_46eb1235>
   ```

### 步骤 2: 配置 Git 凭据

在终端执行以下命令，按提示输入：

```bash
cd /Users/whl/Documents/traeProject/obsidianPro/myOb

# 配置 Git 使用 macOS 钥匙串存储凭据
git config --global credential.helper osxkeychain

# 触发一次推送，系统会提示输入用户名和密码
git push origin main
```

**当提示时输入**:
- **Username**: `whlmpower`
- **Password**: 粘贴你刚才复制的 Token

✅ 输入成功后，Git 会自动将 Token 保存到钥匙串，后续无需再输入！

### 步骤 3: 验证配置

```bash
# 检查凭据是否已保存
git credential-osxkeychain get <<< "protocol=https
host=github.com" 2>&1

# 或者直接推送测试
git push origin main
```

---

## 🔄 备选方案：SSH 方式（如果 HTTPS 不可行）

如果你的 SSH 公钥已添加到 GitHub，可以切换到 SSH 方式：

### 步骤 1: 修改远程仓库地址

```bash
cd /Users/whl/Documents/traeProject/obsidianPro/myOb
git remote set-url origin git@github.com:whlmpower/myOb.git
```

### 步骤 2: 测试 SSH 连接

```bash
ssh -T git@github.com
```

预期输出：
```
Hi whlmpower! You've successfully authenticated, but GitHub does not provide shell access.
```

### 步骤 3: 推送测试

```bash
git push origin main
```

---

## ⚡ 快速修复：一键配置脚本

我已为你创建了配置脚本，执行以下命令：

```bash
cd /Users/whl/Documents/traeProject/obsidianPro/myOb
./setup-github-auth.sh
```

脚本会自动：
1. 配置 Git 凭据助手
2. 提示你输入 GitHub Token
3. 测试推送
4. 验证配置

---

## 🔧 Obsidian Git 插件配置

### 检查插件设置

1. 打开 Obsidian → Settings → Community plugins → Git
2. 确认以下设置：
   - ✅ **Disable push**: 未勾选
   - ✅ **Pull before push**: 已勾选
   - **Remote**: `origin`
   - **Branch**: `main`

### 常用命令

在 Obsidian 命令面板（`Cmd/Ctrl + P`）中搜索：
- `Git: Push` - 推送
- `Git: Pull` - 拉取
- `Git: Sync` - 同步（提交+推送）
- `Git: Commit all changes` - 提交所有更改

---

## ❓ 常见问题

### Q: 为什么不能直接输入 GitHub 密码？

**A**: GitHub 已于 2021 年 8 月 13 日停止支持密码认证，必须使用：
- Personal Access Token (PAT)
- SSH 密钥

### Q: Token 复制后丢失了怎么办？

**A**: 删除旧 Token，重新生成：
1. GitHub → Settings → Developer settings → Personal access tokens
2. 找到旧 Token，点击 Delete
3. 生成新 Token

### Q: SSH 方式连接超时怎么办？

**A**: 可能是网络问题，建议使用 HTTPS + Token 方式。

### Q: 如何查看已保存的凭据？

**A**: 打开 macOS 钥匙串访问（Keychain Access），搜索 `github.com`。

### Q: Obsidian 插件仍然提示输入密码？

**A**: 确保：
1. Git 配置正确：`git config --global credential.helper osxkeychain`
2. 已成功推送过一次（凭据已保存）
3. 重启 Obsidian

---

## 📞 获取帮助

- GitHub Token 文档: https://docs.github.com/en/authentication/creating-a-personal-access-token
- Obsidian Git 插件: https://github.com/denolehov/obsidian-git
- SSH 密钥配置: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

---

## ✅ 完成检查清单

完成以下步骤后，Obsidian Git 插件即可正常推送：

- [ ] 创建 GitHub Personal Access Token
- [ ] 在终端执行 `git push` 并输入 Token
- [ ] 凭据保存成功（钥匙串中可查）
- [ ] Obsidian 中点击 Push 成功
