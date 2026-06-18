---
tags:
  - Obsidian插件
  - Dataview
date: 2025-06-15
---

# Dataview 使用指南

## 一、简介

Dataview 是 Obsidian 最强大的数据查询插件，可以用类似 SQL 的语法查询笔记中的元数据，并以表格、列表、任务等形式展示结果。

---

## 二、前提：Frontmatter（YAML 前置信息）

Dataview 的核心是**查询笔记的元数据**，所以先学会在笔记开头写 frontmatter：

```yaml
---
title: 我的读书笔记
author: 刘慈欣
rating: 5
tags:
  - 读书
  - 科幻
date: 2025-06-15
status: 完成
---
```

写好 frontmatter 后，Dataview 就能查询这些字段了。

---

## 三、四种查询类型

### 1. TABLE — 表格查询（最常用）

````markdown
```dataview
TABLE author, rating, date
FROM #读书
WHERE rating >= 4
SORT rating DESC
```
````

**效果**：列出所有 `#读书` 标签下评分 ≥ 4 的笔记，显示作者、评分、日期，按评分降序。

### 2. LIST — 列表查询

````markdown
```dataview
LIST
FROM #项目
WHERE status = "进行中"
```
````

### 3. TASK — 任务查询

````markdown
```dataview
TASK
WHERE !completed
GROUP BY file.link
```
````

**效果**：汇总所有未完成的任务，按文件分组显示。

### 4. CALENDAR — 日历视图

````markdown
```dataview
CALENDAR date
FROM #日记
```
````

---

## 四、常用语法详解

### `FROM` — 数据来源

```dataview
FROM "日记"              /* 指定文件夹 */
FROM #读书                /* 指定标签 */
FROM #读书 OR #电影       /* 多标签（或） */
FROM #读书 AND #已读      /* 多标签（且） */
FROM "日记" AND #重要     /* 文件夹 + 标签 */
FROM ""                   /* 全库所有笔记 */
```

### `WHERE` — 过滤条件

```dataview
WHERE rating >= 4                        /* 数值比较 */
WHERE status = "完成"                     /* 字符串等于 */
WHERE contains(tags, "科幻")             /* 标签包含 */
WHERE contains(file.name, "学习")        /* 文件名包含 */
WHERE file.ctime >= date("2025-01-01")   /* 创建时间 */
WHERE file.mday >= date(today) - dur(7 days) /* 最近7天修改 */
WHERE file.tags AND length(file.tags) > 3    /* 标签数 > 3 */
```

### `SORT` — 排序

```dataview
SORT file.mtime DESC          /* 按修改时间降序 */
SORT rating ASC               /* 按评分升序 */
SORT file.name ASC            /* 按文件名排序 */
```

### `GROUP BY` — 分组

```dataview
TABLE rows.file.link, rows.rating
FROM #读书
GROUP BY author                /* 按作者分组 */
```

### `LIMIT` — 限制数量

```dataview
LIST
FROM #日记
SORT file.mtime DESC
LIMIT 10                       /* 只显示最近10条 */
```

---

## 五、内联字段（不需要 frontmatter）

在笔记正文中直接写字段，也能被查询：

```markdown
今天心情:: 开心
耗时:: 2小时
重要性:: 高
```

查询时直接用字段名：

````markdown
```dataview
TABLE 耗时, 重要性
FROM #任务
WHERE 重要性 = "高"
```
````

---

## 六、实用示例速查

### 📚 我的书单

````markdown
```dataview
TABLE author AS 作者, rating AS 评分, date AS 日期
FROM #读书
SORT rating DESC
```
````

### 📋 本周任务汇总

````markdown
```dataview
TASK
WHERE !completed AND file.mday >= date(today) - dur(7 days)
GROUP BY file.link
```
````

### 📅 最近修改的笔记

````markdown
```dataview
TABLE file.mtime AS 最后修改
FROM ""
SORT file.mtime DESC
LIMIT 20
```
````

### 📊 按状态统计项目

````markdown
```dataview
TABLE length(rows) AS 数量
FROM #项目
GROUP BY status
```
````

---

## 七、DataviewJS（进阶）

当 DQL 不够用时，可以用 JavaScript：

````markdown
```dataviewjs
const pages = dv.pages("#读书")
    .where(p => p.rating >= 4)
    .sort(p => p.rating, "desc")
    .limit(5)

dv.table(["标题", "作者", "评分"],
    pages.map(p => [p.file.link, p.author, p.rating])
)
```
````

---

## 八、注意事项

- 字段名**区分大小写**：`rating` ≠ `Rating`
- 字符串用**英文双引号**：`"完成"` ✓ `'完成'` ✗
- 查询结果**实时更新**，修改 frontmatter 后自动刷新
- 用 `file.` 前缀访问文件属性：`file.name`、`file.path`、`file.ctime`、`file.mtime`、`file.tags`、`file.link`
