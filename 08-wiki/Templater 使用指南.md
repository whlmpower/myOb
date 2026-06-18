---
tags:
  - Obsidian插件
  - Templater
date: 2025-06-15
---

# Templater 使用指南

## 一、简介

Templater 是 Obsidian 的高级模板引擎，支持动态变量、用户输入、JavaScript 脚本，能快速生成结构化的笔记内容。

---

## 二、基本设置

### 1. 安装后配置模板文件夹

> 设置 → 社区插件 → Templater → **Template folder location**

建议设置为 `06-Templates` 文件夹。

### 2. 开启功能

在 Templater 设置中建议开启：
- ✅ **Trigger Templater on new file creation** — 新建笔记自动触发
- ✅ **Enable system commands** — 执行系统命令（高级）

---

## 三、模板语法基础

### 常用内置变量

| 语法 | 说明 | 输出示例 |
|------|------|----------|
| `<% tp.date.now("YYYY-MM-DD") %>` | 今天日期 | `2025-06-15` |
| `<% tp.file.title %>` | 当前文件名 | `我的笔记` |
| `<% tp.file.creation_date() %>` | 文件创建时间 | `2025-06-15 10:30` |
| `<% tp.file.folder() %>` | 文件所在文件夹 | `日记/2025` |
| `<% tp.file.path() %>` | 文件完整路径 | `日记/2025/06-15.md` |
| `<% tp.system.clipboard() %>` | 剪贴板内容 | _(剪贴板文本)_ |

---

## 四、完整模板示例

### 📅 每日日记模板

```markdown
<%*
const title = tp.date.now("YYYY-MM-DD");
await tp.file.rename(title);
_%>
---
date: <% tp.date.now("YYYY-MM-DD") %>
tags:
  - 日记
---

# <% tp.date.now("YYYY-MM-DD dddd") %>

## 🌤️ 今日心情

## 📝 今日记录

## ✅ 今日任务
- [ ] 
- [ ] 
- [ ] 

## 📖 今日学习

## 💡 今日反思

---
> 昨天回顾: [[<% tp.date.now("YYYY-MM-DD", -1) %>]]
> 明天计划: [[<% tp.date.now("YYYY-MM-DD", 1) %>]]
```

### 📚 读书笔记模板

```markdown
---
title: <% tp.file.title %>
author: 
rating: 
date: <% tp.date.now("YYYY-MM-DD") %>
status: 读完
tags:
  - 读书
---

# 《<% tp.file.title %>》

## 📖 基本信息
- **作者**: 
- **评分**: /5
- **阅读时间**: <% tp.date.now("YYYY-MM-DD") %> ~ 

## 📝 核心观点

## 💡 金句摘录

## 🤔 个人思考

## 📋 行动清单
- [ ] 
```

### 🗓️ 周报模板

```markdown
---
date: <% tp.date.now("YYYY-MM-DD") %>
tags:
  - 周报
---

# 周报 <% tp.date.now("YYYY") %> 第 <% tp.date.now("WW") %> 周

## 📅 本周时间
<% tp.date.now("YYYY-MM-DD", -7) %> ~ <% tp.date.now("YYYY-MM-DD") %>

## ✅ 本周完成

## 🚧 进行中

## 📌 下周计划

## 💭 总结反思
```

---

## 五、高级语法

### 1. 用户输入提示

```markdown
<%*
const type = await tp.system.suggester(
    ["读书", "电影", "课程", "其他"],
    ["读书", "电影", "课程", "其他"]
);
_%>
**类型**: <% type %>

**评分**: <% await tp.system.prompt("输入评分 (1-5)", "3") %>

**简介**: <% await tp.system.prompt("一句话简介") %>
```

使用模板时会**弹出输入框**让你选择或填写。

### 2. 条件判断

```markdown
<%*
const status = await tp.system.suggester(
    ["✅ 已完成", "🚧 进行中", "❌ 取消"],
    ["完成", "进行中", "取消"]
);
_%>
status: <% status %>

<% if (status === "完成") { %>
completion_date: <% tp.date.now("YYYY-MM-DD") %>
<% } %>
```

### 3. 循环生成

```markdown
## 每周习惯追踪
| 习惯 | 一 | 二 | 三 | 四 | 五 | 六 | 日 |
|------|--|--|--|--|--|--|--|
<%*
const habits = ["早起", "阅读", "运动", "冥想"];
for (const habit of habits) {
%>
| <% habit %> | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ | ⬜ |
<%* } %>
```

---

## 六、使用模板的方式

### 方式 1：命令面板
```
Ctrl/Cmd + P → Templater: Insert Template → 选择模板
```

### 方式 2：快捷键绑定
> 设置 → 快捷键 → 搜索 `Templater` → 绑定 `Insert Template`

### 方式 3：自动触发
> Templater 设置 → 开启 **Trigger Templater on new file creation**

### 方式 4：侧边栏图标
点击左侧边栏的 Templater 图标（纸飞机）快速插入。

---

## 七、文件夹模板映射（自动关联）

在 Templater 设置的 **Folder Templates** 中：

| 文件夹 | 对应模板 |
|--------|----------|
| `01-Daily` | `06-Templates/日记模板.md` |
| `02-Reading` | `06-Templates/读书笔记.md` |
| `03-Projects` | `06-Templates/项目模板.md` |

设置后，在对应文件夹新建笔记**自动使用对应模板**。

---

## 八、常用日期格式速查

| 格式代码 | 输出 | 说明 |
|----------|------|------|
| `YYYY` | 2025 | 四位年份 |
| `MM` | 06 | 两位月份 |
| `DD` | 15 | 两位日期 |
| `dddd` | Sunday | 星期全称 |
| `ddd` | Sun | 星期缩写 |
| `HH` | 14 | 24小时制 |
| `mm` | 30 | 分钟 |
| `WW` | 24 | 第几周 |

---

## 九、常见问题

### Templater error: No active Editor

表示没有打开/聚焦的笔记编辑器。

**解决**：
1. 先打开一个笔记
2. 点击笔记正文区域（确保光标在闪烁）
3. 再执行模板插入

---

## 💡 Tips

1. **模板文件本身不会被解析** — 只有插入到其他笔记时才会执行
2. **`<%*` 开头表示 JS 代码块** — 可以写复杂逻辑
3. **`<% -%>` 消除多余空行** — 让输出更整洁
4. **`await` 关键字** — 遇到 `tp.system.prompt` 等交互函数必须加 `await`
5. **配合 Dataview 使用** — 模板生成规范 frontmatter，Dataview 负责查询聚合
