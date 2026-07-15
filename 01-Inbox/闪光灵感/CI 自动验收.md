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

CI 自动验收的本质是：**任何代码合并前，必须通过预设的所有检查关卡，否则 PR 无法合并。**

你已经有了流水线配置文件，我帮你梳理一下现状和还需要做的事。

---

### 一、你已经有的（已完成）

|组件|状态|说明|
|---|---|---|
|`.github/workflows/ci.yml`|已创建|4 个 Job：Java 测试、admin-ui 构建、h5-ui 构建、前端测试|
|后端单元测试|28 个通过|EvalRecordServiceTest 等|
|h5-ui Vitest 配置|已创建|vitest.config.js + 2 个测试文件|
|h5-ui package.json|已更新|添加了 vitest 依赖和 test 脚本|

---

### 二、你还需完成的（分三步）

#### 第一步：让前端测试能跑起来（立即可做）

当前 h5-ui 的 vitest 依赖还没安装。在 `h5-ui/` 目录下执行：

```bash
cd h5-ui
npm install --registry=https://registry.npmmirror.com/
npx vitest run
```

如果跑通看到绿色输出，前端的测试关卡就通了。

> 如果遇到 import 路径的问题（比如 `./constants.js` 在某些环境下需要 `.js` 后缀），告诉我，我帮你调。

---

#### 第二步：在 GitHub 上启用分支保护（关键）

这是**把 CI 变成硬性门槛**的一步。没有这个，CI 跑了但别人可以直接跳过合并。

去你的 GitHub 仓库 → **Settings → Branches → Branch protection rules**：

```
保护分支：master 和 develop

勾选以下选项：
  ☑ Require a pull request before merging
      ☑ Require approvals: 1（至少 1 人 review）
  
  ☑ Require status checks to pass before merging
      ☑ Require branches to be up to date
      选择以下 checks：
        · java-test
        · admin-ui-build  
        · h5-ui-build
        · frontend-test

  ☑ Require conversation resolution before merging
  
  ☑ Do not allow bypassing the above settings
     （管理员也不能跳过，确保 CI 必须过）
```

这样设置后，**任何 PR 只要有一个 Job 失败，合并按钮就是灰色的，点不了。**

---

#### 第三步：补全其他 Service 的测试（逐步做）

目前只有 `EvalRecordService` 有完整的单元测试。建议按以下优先级补充：

```
优先级 1（核心业务）：
  - EvalProjectService    → 项目 CRUD、开启/关闭评估
  - EvalSystemService     → 评估体系管理

优先级 2（涉及外部依赖）：
  - LoginService          → 登录、短信验证（已有逻辑可参考）
  - SysConfigService      → 系统配置

优先级 3（可选，时间充裕时）：
  - Controller 层集成测试（@SpringBootTest + MockMvc）
  - admin-ui 的 Vitest 组件测试
```

---

### 三、CI 流水线当前的 Job 逻辑

你的 `ci.yml` 触发条件：

```yaml
# 以下情况自动触发 CI：
on:
  push:
    branches: [ develop, supplier-reverse-evaluation ]   # 推代码到这些分支
  pull_request:
    branches: [ master, develop ]                        # PR 目标分支是这些
```

流水线执行顺序：

```
并行执行（同时跑）：
  Job 1: java-test          → mvn test（~40 秒）
  Job 2: admin-ui-build     → npm install + npm run build（~1 分钟）
  Job 3: h5-ui-build        → npm install + npm run build（~1 分钟）
  Job 4: frontend-test      → npx vitest run（~10 秒）

全部通过后：
  Job 5: all-checks         → 汇总确认，输出结果
```

任何一个 Job 失败 → 整个 CI 失败 → PR 无法合并。

---

### 四、与卡兹克文章的对应关系

|文章说的|你的实现|
|---|---|
|Agent 提测 → 测试约 5 分钟|`mvn test` 约 40 秒 + 前端构建约 2 分钟，总计约 3 分钟|
|被打回 → 修复 → 再提测|CI 失败 → Agent 看日志 → 修复 → push → 重新触发 CI|
|CI 自动验收，过不了无法合并|GitHub Branch Protection + required status checks|
|自建 CI 服务器做任务路由|目前用 GitHub 托管 Runner，后续可迁移到自建|

---

### 五、下一步行动清单

按顺序执行即可：

```
1. [ ] cd h5-ui && npm install && npx vitest run        ← 验证前端测试能跑
2. [ ] GitHub Settings → Branch protection → 配置保护规则  ← 让 CI 变成硬门槛
3. [ ] push 代码到 GitHub，观察第一次 CI 运行             ← 确认流水线正常
4. [ ] 逐步补充其他 Service 的测试                        ← 提高覆盖率
```

### 为什么单人项目更需要 CI

| 场景             | 没有 CI 的风险        | CI 帮你挡住的        |
| -------------- | ---------------- | --------------- |
| AI 助手生成代码后直接提交 | 代码有 bug 直接上线     | 自动跑测试，不合格不让合    |
| 深夜赶功能，状态不好     | 低级错误（拼写、空指针）漏到生产 | 测试帮你兜底          |
| 改了一个方法，影响了很多地方 | 没注意到副作用          | 回归测试发现破坏        |
| "先合上去，之后再补测试"  | 测试永远补不上          | 合并门槛强制要求        |
| 换个电脑/重装环境      | "在我机器上是好的"       | CI 在干净环境下跑，环境无关 |

CI 本身是工具，**真正挡 bug 的是你写测试的习惯**。

你的文章里最值得复用的经验其实是这个顺序：

```
1. 先写测试（TDD）
2. 让 Agent 实现功能
3. CI 自动跑测试验证
4. 过了 → 自动部署
5. 没过 → Agent 看日志修复 → 重新来
```

## 我的理解

## 后续行动
- [ ] 
