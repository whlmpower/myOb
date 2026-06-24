---
type: web-clip
source:
status: inbox
tags:
  - web
---

# 网页标题

## 一句话摘要
Headroom 是一个 **AI 上下文压缩层**，在工具输出、日志、文件、RAG 结果送达 LLM 之前进行压缩，声称减少 60-95% token 用量且答案质量不变

## 关键内容

|模式|说明|
|---|---|
|**Library**|compress(messages) 内嵌到你自己的代码里|
|**Proxy**|headroom proxy --port 8787，零代码改动，任何语言都能用|
|**MCP Server**|提供 headroom_compress、headroom_retrieve、headroom_stats 工具|

## 如何使用（最简单的方式）

## codex

`# 1. 安装 pip install "headroom-ai[all]" 
```
# 2. 一行命令包装 Codex headroom wrap codex`
```

headroom wrap codex 会自动启动本地代理并包装 Codex 的请求，你不需要改任何代码。

## 其他使用方式

`# 作为独立代理（适合任何 OpenAI 兼容客户端） headroom proxy --port 8787 # 作为 MCP Server 安装到 Codex headroom mcp install # 查看节省效果 headroom perf headroom dashboard`

## ClaudeCode

## 三种使用方式

### 方式 1：MCP Server（推荐 - 原生集成）

`# 一次性注册到 Claude Code headroom mcp install # 启动 Claude Code claude`

注册后，Claude Code 会获得三个 MCP 工具：

- headroom_compress - 压缩内容
- headroom_retrieve - 检索原始内容
- headroom_stats - 查看压缩统计

Claude 会在需要时自动调用这些工具压缩大型输出。

### 方式 2：代理模式（零代码改动 - 自动压缩所有流量）

`# 终端 1：启动代理 headroom proxy --port 8787 # 终端 2：通过代理启动 Claude Code ANTHROPIC_BASE_URL=http://127.0.0.1:8787 claude`

所有 API 请求都会经过代理自动压缩，无需修改任何代码。

### 方式 3：一行命令包装（最简单）

`headroom wrap claude`

这会自动启动代理并包装 Claude Code 的请求。

## 配置说明

安装后会创建配置文件：

`{ "mcpServers": { "headroom": { "type": "stdio", "command": "headroom", "args": ["mcp", "serve"] } } }`

如果 headroom 命令不在 PATH 中（比如在虚拟环境里安装），需要使用绝对路径或全局安装：

`# 全局安装 pipx install "headroom-ai[mcp]" # 或找到绝对路径 where headroom # Windows which headroom # macOS/Linux`

## 验证安装

`# 检查 MCP 状态 headroom mcp status # 查看压缩效果 headroom perf # 启动仪表盘（需要代理运行中） headroom dashboard`


## 我的理解


**Windows 注意**：目前没有预编译的 Windows 轮子，需要：

1. 安装 **Visual Studio Build Tools**（选择 "Desktop development with C++"）
2. 安装 **Rust**（rustup default stable）
3. 重启 PowerShell 后再安装

或者用 Docker 避免本地编译：

`docker pull ghcr.io/chopratejas/headroom:latest`


## 后续行动
- [ ] 
