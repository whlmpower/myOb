---
type: web-clip
source:
status: inbox
tags:
  - web
  - AI
---

# 网页标题
Superpowers 超能力技能完整使用教程（带实战需求示例）


## 一句话摘要

## 关键内容

## 一、Superpowers 是什么

Superpowers 是 Open Design / Claude Code 内置**标准化工程流程技能合集**，相当于给 AI 一套强制开发规范，杜绝 AI 随便写代码、漏测试、需求跑偏。

内置一整套串联技能：

1. `brainstorming` 头脑风暴（需求澄清）
2. `writing-plans` 拆解微任务计划
3. `using-git-worktrees` 隔离开发分支
4. `test-driven-development` TDD 测试驱动开发
5. `subagent-driven-development` 多子代理并行开发
6. `requesting-code-review` 双维度代码审查
7. `verification-before-completion` 上线前全量校验

### 两种触发方式

1. **自动触发（推荐）**
    
    你直接丢开发需求，AI 识别到需要落地功能，会**强制自动加载 superpowers 全流程**，不用手动命令。
2. **手动显式调用**
    
    两种写法任选其一：

plaintext

```
请使用 superpowers:brainstorming 梳理这个需求
/brainstorm 开发移动端会员中心页面接口
```

## 二、完整实战需求示例

### 需求背景

> 需求：给 SaaS 后台新增**会员充值模块**，包含充值套餐选择、微信支付跳转、充值记录列表、余额自动更新，使用 SpringBoot + Vue3，要求接口幂等、全覆盖单元测试、代码评审。

### 完整分步操作（Superpowers 标准 7 步流程）

#### 步骤 1：启动 Superpowers，触发 brainstorming 需求澄清

输入指令（两种方式任选）

方式 1（自然语言自动触发）

plaintext

```
用superpowers完整流程开发SaaS后台会员充值模块，SpringBoot后端+Vue3前端，包含充值套餐、微信支付回调、充值流水、余额更新，接口防重复回调，写单元测试并自动代码审查
```

方式 2（斜杠命令强制启动）

plaintext

```
/brainstorm SaaS后台会员充值模块，SpringBoot+Vue3，支持套餐充值、微信支付、流水记录、余额，幂等防重复支付
```

##### Superpowers 执行行为

AI 不会直接写代码，严格走苏格拉底式提问，一次只问 1 个问题澄清边界：

1. 充值套餐是否支持自定义金额，还是固定档位？
2. 微信支付回调失败如何重试，补偿逻辑？
3. 余额更新是否加分布式锁防止并发超扣？
4. 充值记录是否需要分页、筛选、导出？
5. 异常订单（支付超时 / 金额不符）状态流转规则？

你逐条回复确认后，AI 自动输出标准化设计文档 `docs/superpowers/specs/会员充值-design.md`，包含：业务流程、数据库表结构、接口清单、异常分支、幂等方案。

#### 步骤 2：writing-plans 拆分可执行微任务

确认设计文档后，Superpowers 自动进入拆计划阶段，输出 `plans/会员充值-task.md`，把大功能拆成**2-5 分钟可完成**的最小任务，每个任务包含：

- 修改文件路径
- 预期代码逻辑
- 配套测试用例
- 验证命令
    
    示例任务片段：

1. 创建充值套餐表 recharge_package，编写 Mybatis 实体与 Mapper
2. 编写套餐查询后端接口，先写单元测试再实现逻辑
3. 新增余额表更新接口，加分布式锁防并发
4. 微信支付回调幂等校验逻辑，唯一标识防重复执行
5. Vue3 充值页面组件、套餐渲染、支付弹窗
6. 充值记录分页列表、筛选功能
7. 全模块代码自检 + 规范评审

#### 步骤 3：using-git-worktrees 创建隔离开发环境

Superpowers 自动创建独立 Git 工作树，不污染主分支，所有代码、测试、文档变更隔离，方便随时丢弃 / 合并，避免改坏线上代码。

#### 步骤 4：test-driven-development TDD 测试驱动开发（核心）

对每一条拆分任务，强制红 - 绿 - 重构循环：

1. RED：先写失败的单元测试（未实现功能，测试报错）
2. GREEN：写最少业务代码让测试全部通过
3. REFACTOR：优化代码结构，保持测试不报错
    
    以「微信支付回调幂等」举例：

- 先写并发重复回调的测试用例（模拟 2 次同时推送）
- 实现基于支付单号的幂等记录表逻辑
- 重构抽离公共校验工具类，复测所有用例

#### 步骤 5：subagent-driven-development 多代理并行开发

Superpowers 自动分派 3 个子代理同步工作：

- 实现代理：写业务代码 + 单元测试
- 规格审查代理：核对代码是否和 design.md 需求一致
- 质量审查代理：检查命名、异常捕获、SQL 性能、安全漏洞
    
    多任务可以并行执行，缩短开发时间。

#### 步骤 6：requesting-code-review 双层代码审查

全部功能写完后自动两轮评审：

1. 需求合规审查：有没有超出需求范围、漏功能、逻辑和设计不符
2. 代码质量审查：无硬编码、无 SQL 注入、事务边界正确、测试覆盖率达标
    
    出现问题会退回对应任务重新修改，不允许直接收尾。

#### 步骤 7：verification-before-completion 上线前全量校验

自动执行全套验证：

1. 运行所有单元测试，通过率 100% 才可完成
2. 核对数据库表、接口、页面全部交付
3. 输出交付清单：接口文档、测试报告、SQL 脚本、前端页面代码
4. 归档全套设计 + 计划文档，存入项目目录

## 三、社区模板搭配 Superpowers 进阶用法

你之前提到首页 Community 大量模板，两者可以组合使用，效率翻倍：

1. 打开 Community，Fork 一个`saas-dashboard`后台模板
2. 加载模板页面结构、组件、路由
3. 输入 Superpowers 指令：`基于当前后台模板，用superpowers开发会员充值模块`
4. AI 复用模板已有布局、请求封装、全局样式，不再重复搭建基础页面，直接聚焦业务功能

### 组合示例完整指令（直接复制使用）

plaintext

```
Fork当前community的saas-dashboard后台模板，使用完整superpowers流程开发会员充值模块，SpringBoot后端+Vue3前端，包含充值套餐、微信支付回调幂等处理、充值流水列表、用户余额更新，全部TDD开发，完成自动代码审查和测试校验
```

## 四、常用 Superpowers 快捷命令速查

plaintext

```
# 需求梳理阶段
/brainstorm "xxx功能需求"

# 已有方案，直接生成执行计划
/write-plan docs/plans/recharge.md

# 排查bug专用superpowers技能
/superpowers:systematic-debugging 充值回调并发扣减余额bug

# 完成后自动代码评审
/review-code
```

## 五、常见使用问题

1. AI 不自动走 Superpowers 流程
    
    手动加前缀：`请完整启用superpowers所有技能执行下面需求`
2. 只想简单写页面，不需要完整 TDD 评审
    
    可裁剪：`只使用superpowers:brainstorming梳理页面需求，不需要单元测试和代码审查`
3. Community 模板和 Superpowers 冲突
    
    先 Fork 模板加载页面结构，再输入 superpowers 开发业务功能，模板基础组件会自动复用

需要我给你一段可直接复制的**Superpowers 完整通用开发指令**，适配后台 / 前端页面 / 接口开发吗？


# 通用 Superpowers 完整指令（3 套场景，直接复制即用）

## 1. 前端页面开发（搭配 Community 社区模板，最常用）

适用：后台页面、官网、移动端页面、基于社区模板二次开发

plaintext

```
启用完整 Superpowers 全流程开发，基于当前打开的 Community 模板进行开发，严格遵循流程：头脑风暴梳理需求→输出开发规划→TDD开发→多代理并行编码→代码评审→全量校验交付。
需求：{把你的页面需求替换在这里}
约束：复用现有模板组件、样式、路由、请求封装；统一代码规范；补充交互逻辑；产出完整可直接运行页面代码，附带简单交互测试用例。
```

### 实操示例（填充完整可直接发）

plaintext

```
启用完整 Superpowers 全流程开发，基于当前打开的 Community 模板进行开发，严格遵循流程：头脑风暴梳理需求→输出开发规划→TDD开发→多代理并行编码→代码评审→全量校验交付。
需求：搭建后台用户管理列表页，支持分页、搜索、状态筛选、新增/编辑弹窗、批量删除，表格自带操作按钮
约束：复用现有模板组件、样式、路由、请求封装；统一代码规范；补充交互逻辑；产出完整可直接运行页面代码，附带简单交互测试用例。
```

## 2. 前后端一体开发（SpringBoot + Vue/React）

适用：完整业务模块、接口 + 页面联调

plaintext

```
开启全部 Superpowers 流水线开发，步骤：需求澄清→输出设计文档（库表、接口、业务流程）→拆分任务→TDD测试驱动编码→双代理代码审查→上线全量验证。
需求：{填写业务模块需求}
技术栈：SpringBoot3 + Mybatis-Plus + Vue3 Element Plus
强制要求：接口幂等处理、事务控制、并发安全、完整单元测试、无SQL注入、接口文档随代码一并输出。
```

## 3. 轻量化简化版（只梳理方案，不需要单元测试 / 评审）

适合快速出页面、简单活动页、海报页面，不想走复杂校验流程

plaintext

```
仅启用 Superpowers 的 brainstorming、write-plan 能力，跳过TDD、代码审查、多代理流程，快速完成开发。
需求：{简单页面需求}
要求：基于现有社区模板快速修改，输出干净可运行代码，不用写测试用例。
```

# 配套使用步骤（模板 + Superpowers 标准操作流程）

1. 首页 Community 选中模板 → Use Template 载入项目
2. 清空原有对话，复制上面对应场景指令，替换你的需求
3. 发送，AI 自动走 superpowers 流程，复用模板现有布局、组件
4. 中途如果想跳过某环节，补充一句：`跳过代码评审环节，直接输出完整代码`
## 我的理解

## 后续行动
- [ ] 
