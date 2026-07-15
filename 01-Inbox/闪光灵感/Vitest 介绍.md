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

## Vitest 介绍

### 它是什么

Vitest 是 **Vite 官方推出的前端单元测试框架**，由 Vue 团队维护。简单说就是：

> **专门给 Vite 项目用的测试工具，跟你现有的 h5-ui 和 admin-ui 完美兼容。**

---

### 为什么选 Vitest（而不是 Jest、Mocha 等）

|对比项|Vitest|Jest|Mocha|
|---|---|---|---|
|与 Vite 集成|原生支持，共享 Vite 配置|需要额外配置|需要额外配置|
|启动速度|极快（利用 Vite 缓存）|较慢|中等|
|Vue 组件测试|官方支持 (`@vue/test-utils`)|支持但需配置|支持但需配置|
|配置复杂度|极少，一个文件搞定|较多|多|
|热更新|有（watch 模式）|有|需额外配置|
|覆盖率报告|内置|内置|需额外配置|

**关键优势：你的项目用 Vite 构建，Vitest 直接复用 Vite 的 alias、plugin、环境变量，零额外配置成本。**

---

### 核心概念（三个东西）

```
1. 测试框架（Test Runner）
   - 负责发现和运行测试文件
   - 约定：文件名以 .test.js / .spec.js 结尾

2. 断言库（Assertion）
   - 负责判断"对还是错"
   - 比如：expect(a).toBe(b)、expect(array).toContain(item)

3. Mock（模拟）
   - 在测试中替换真实的依赖（API、DOM、localStorage 等）
   - 让你不用启动真实环境就能测试逻辑
```

Vitest 这三样都内置了，**不需要额外安装**。

---

### 一个最简单的例子

你项目里 `h5-ui/src/shared/utils/constants.js` 定义了很多状态枚举：

```javascript
// constants.js（你现有的代码）
export const PROJECT_STATUS = {
  NOT_OPEN: 1,
  EVALUATING: 2,
  CLOSED: 3
}
```

对应的测试文件 `constants.test.js`：

```javascript
// constants.test.js（测试代码）
import { describe, it, expect } from 'vitest'
import { PROJECT_STATUS } from './constants.js'

describe('PROJECT_STATUS 枚举', () => {
  it('应该有 3 种状态', () => {
    expect(PROJECT_STATUS.NOT_OPEN).toBe(1)
    expect(PROJECT_STATUS.EVALUATING).toBe(2)
    expect(PROJECT_STATUS.CLOSED).toBe(3)
  })
})
```

运行 `npx vitest run`，看到绿色通过就说明这个模块的功能正确。

### 在你的项目中的角色

前面文章提到的**自动化测试关卡**中，Vitest 对应的是**前端部分的测试关卡**：

```
Agent 提交代码
    ↓
├── Java 单元测试（Maven test）→ 测后端业务逻辑
├── 前端单元测试（Vitest）   → 测前端工具函数、组件
└── 前端构建验证（npm run build） → 确保代码能编译
```

- **后端 Java 测试** → 确保接口逻辑不出 bug
- **前端 Vitest 测试** → 确保前端工具函数、表单验证、状态映射不出 bug
- **前端构建** → 确保代码语法/类型没问题

三者都通过 → CI 绿灯 → 可以合并。
## 我的理解

## 后续行动
- [ ] 
