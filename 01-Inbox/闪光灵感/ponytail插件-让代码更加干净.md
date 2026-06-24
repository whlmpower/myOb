---
type: web-clip
source:
status: inbox
tags:
  - web
---

# 网页标题

## 一句话摘要

## 关键内容

插件命令有两种用法：

### 1. 切换模式（影响后续所有对话）

直接输入命令即可：

```
/ponytail full
```

之后你正常描述任务，ponytail 规则会自动生效。比如：

```
/ponytail full
帮我写一个用户列表页面的分页功能
```

代理会优先考虑用最简方案实现。

### 2. 审查已有代码

先做出修改（或让代理修改），然后用 `/ponytail-review` 审查当前 diff：

```
/ponytail-review
```

它会逐行分析，告诉你哪些可以删掉，格式如：

```
L42: delete  unused import     → remove
L58: shrink  重复逻辑          → extract to one-liner
```

### 实际工作流示例

```
你: /ponytail full
你: 帮我写一个日期选择器
代理: <input type="date">   ← 直接用浏览器原生，不装依赖

你: /ponytail-review         ← 再检查一遍有没有多余代码
```

简单说：**先切模式，再提需求，最后 review**。模式对当前会话内所有后续对话都生效。

## 我的理解

## 后续行动
- [ ] 在新的项目中，使用试一下，旧的项目让他review代码，改造一下
