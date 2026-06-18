---
tags:
  - Obsidian插件
  - Calendar
date: 2025-06-15
---

# Calendar 使用指南

## 一、简介

Calendar 是 Obsidian 的日历面板插件，提供可视化的月历视图，可以快速导航和创建每日/每周/每月笔记。配合 Daily Notes 和 Periodic Notes 插件使用效果最佳。

---

## 二、安装与基本设置

### 安装
> 设置 → 社区插件 → 浏览 → 搜索 **Calendar** → 安装 → 启用

### 启用后
左侧边栏会出现一个 **日历图标**，点击打开日历面板。

### 核心设置

> 设置 → Community plugins → Calendar

| 设置项 | 推荐值 | 说明 |
|--------|--------|------|
| **Start week on** | Monday | 周一为一周起始 |
| **Words per dot** | 100 | 每个圆点代表多少字 |
| **Show week numbers** | ✅ | 显示第几周 |

---

## 三、配合 Daily Notes 使用

Calendar 的核心功能是和 **每日笔记** 配合。

### 1. 开启 Daily Notes
> 设置 → 核心插件 → 开启 **Daily notes**

### 2. 配置 Daily Notes

| 设置项 | 推荐值 |
|--------|--------|
| **日期格式** | `YYYY-MM-DD` |
| **新文件位置** | `01-Daily`（你的日记文件夹） |
| **模板文件位置** | `06-Templates/日记模板.md` |

### 3. 使用

- **点击日历上的某一天** → 自动创建/打开那天的日记
- **今天的日期**会高亮显示
- **有内容的日期**下方会显示小圆点，圆点越多字数越多

---

## 四、日历面板功能说明

```
┌─────────────────────────────┐
│       ◀ 2025年6月 ▶          │
│  Mon Tue Wed Thu Fri Sat Sun  │
│                          1    │
│   2   3   4   5   6   7   8  │
│   9  10  11  12  13  14  15● │ ← 今天高亮
│  16  17  18  19  20  21  22  │
│  23  24  25  26  27  28  29  │
│  30                          │
├─────────────────────────────┤
│  [Daily] [Weekly] [Monthly]  │
└─────────────────────────────┘
```

| 操作 | 效果 |
|------|------|
| **单击某天** | 打开该天日记（不存在则创建） |
| **● 小圆点** | 表示该天有日记且有内容 |
| **圆点数量** | 反映笔记字数多少 |
| **左右箭头 ◀ ▶** | 切换月份 |
| **点击月份标题** | 回到当前月份 |

---

## 五、配合 Periodic Notes（周记/月记）

如果还需要**周记、月记**，安装 **Periodic Notes** 插件：

### 安装
> 设置 → 社区插件 → 搜索 **Periodic Notes** → 安装启用

### 配置
> 设置 → Periodic Notes

| 类型 | 日期格式 | 文件夹 | 模板 |
|------|----------|--------|------|
| **Weekly** | `YYYY-[W]WW` | `01-Weekly` | `06-Templates/周报模板.md` |
| **Monthly** | `YYYY-MM` | `01-Monthly` | `06-Templates/月报模板.md` |
| **Yearly** | `YYYY` | `01-Yearly` | — |

开启后，Calendar 面板顶部会出现切换标签：
```
[Daily] [Weekly] [Monthly]
```

---

## 六、打开 Calendar 面板

### 方法 1：点击左侧边栏图标

在左侧边栏找到日历图标点击。

> ⚠️ 注意区分：
> - **Daily Notes 图标**（📅）→ 直接打开今天的日记
> - **Calendar 图标**（📊 月历格子）→ 打开月历面板

### 方法 2：命令面板打开

```
Ctrl/Cmd + P → 输入 "Calendar" → 选择 "Calendar: Open view"
```

---

## 七、常见问题

### Q: 点击日期没有反应？
**A:** 确认 **Daily Notes 核心插件** 已开启，Calendar 依赖它来创建笔记。

### Q: 日期格式不匹配？
**A:** Calendar 用 Daily Notes 设置中的日期格式来查找文件。确保：
- Daily Notes 的日期格式 = 模板中 `tp.date.now()` 的格式
- 例如都用 `YYYY-MM-DD`

### Q: 想用 Templater 模板？
**A:** Daily Notes 的模板设置中填入 Templater 模板路径，Templater 会自动处理模板中的 `undefined` 语法。

### Q: 周记怎么创建？
**A:** 安装 Periodic Notes 插件，配置 Weekly 模式，Calendar 面板会出现 Weekly 标签。

---

## 八、完整工作流示例

```
每天早上：
  📅 点击 Calendar 今天的日期
    → 自动创建 2025-06-15.md
    → 自动套用日记模板
    → 开始写日记

每周日：
  📅 切换到 Weekly 视图
    → 点击本周
    → 自动创建 2025-W24.md
    → 写周报总结
```

---

## 💡 最佳搭配

```
Calendar + Daily Notes + Templater + Dataview

Calendar   → 快速导航和创建日记
Templater  → 自动填充模板内容
Dataview   → 汇总查询日记中的任务和笔记
```
