---
type: web-clip
source:
status: inbox
tags:
  - web
  - AI
---

# 网页标题

## 一句话摘要

## 关键内容

指令词：你启动一个子Agent，调研代码，看几个目录，我看看效果


![[Pasted image 20260623104807.png]]


![[Pasted image 20260623105029.png]]


![[Pasted image 20260623105147.png]]

![[Pasted image 20260623105450.png]]

## 我的理解

Codex 中的 subagent 功能通过 multi_agent_v1 工具集实现，包含以下核心操作：

---

## 核心工具

|工具|用途|
|---|---|
|spawn_agent|创建一个子 agent|
|send_input|向已有 agent 发送消息|
|wait_agent|等待 agent 完成|
|close_agent|关闭 agent|
|resume_agent|恢复已关闭的 agent|

---

## 基本用法

### 1. 创建子 agent

添加到对话

`spawn_agent({ message: "你的任务描述", agent_type: "worker", // 可选: default, explorer, worker fork_context: true // 是否继承当前对话历史 })`

返回 agent ID，后续操作都用这个 ID。

### 2. 等待结果

添加到对话

```
wait_agent({ targets: ["agent_id_1", "agent_id_2"], timeout_ms: 60000 })
```

可以同时等待多个 agent。

### 3. 继续对话

添加到对话

`send_input({ target: "agent_id", message: "追加的指令" })`

### 4. 完成后清理

添加到对话

`close_agent({ target: "agent_id" })`

---

## 三种 Agent 角色

- **default** — 通用 agent
- **explorer** — 快速代码库探索，回答具体问题。适合并行提问多个独立问题
- **worker** — 执行生产任务（写代码、修 bug、重构）。需要明确分配文件所有权

---

## 设计原则

**适合委派的场景：**

- 多个独立子任务可以并行执行
- 任务边界清晰、自包含
- 不阻塞你的关键路径

**不适合委派的场景：**

- 下一步立即依赖结果的阻塞任务
- 任务太复杂或耦合太紧
- 需要深度判断的工作

**并行模式：**

- 多个独立探索问题 → 同时 spawn 多个 explorer
- 多个不重叠的代码修改 → 同时 spawn 多个 worker，各自负责不同文件
- 验证任务可以和实现任务并行

---

## 实际例子

假设你要同时了解项目的测试结构和 API 路由：

1. 同时 spawn 两个 explorer，分别问测试结构和路由定义
2. 继续做其他不依赖这些结果的工作
3. 用 wait_agent 等待结果返回
4. 基于结果继续推进

如果你想让我演示一次实际的 subagent 调用，告诉我你的具体任务。


## 后续行动
- [x] 试验了subagent，遇到了“你来读取 而实际并未读取的问题呢” 

codex的回答：
  
这是个好问题。说实话，原因和对策如下：

**根因：** 我在多个轮次中"描述下一步计划"而不是"执行"，导致空转。

**你可以做的事：**

1. **提示词更直接** — 比如"读取这些文件并告诉我用途"，而不是"帮我分析一下"。指令越具体，我越不容易陷入"先解释再做"的循环
2. **加一句"直接给结果"** — 比如"用 subagent 演示，并直接汇总结果给我"，明确跳过中间汇报
3. **小事别用 subagent** — 像这次 7 个文件的分析，直接让我本地读取 1 秒就完事，subagent 反而增加了编排开销和出错概率

**subagent 真正适合的场景：**

- 10+ 个独立模块要并行分析
- 多个 worker 同时改不同文件
- 任务之间互不依赖、可以同时跑

**这次的教训：** subagent 机制本身没问题（通知按时到了），问题出在我收到结果后没有立即整理给你，而是继续说"我来读取"。这是我的执行纪律问题，不是工具或你的配置问题。