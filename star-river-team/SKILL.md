# 星河开发团队 - Skill 使用指南

## 简介

**星河开发团队**是一个由 7 个 AI Agent 组成的专业软件开发团队。每个成员都有明确的中文名、岗位、模型配置和责任边界。

## 团队成员

| 中文名 | 岗位 | Profile | 默认模型 |
|--------|------|---------|----------|
| 凌霄 | 指挥官 | orchestrator | claude-fable-5-1 |
| 诗韵 | 产品经理 | pm | glm-5.3 |
| 洛璃 | 设计师 | designer | kimi-k3 |
| 墨轩 | 架构师 | architect | claude-fable-5-1 |
| 星河 | 前端开发 | frontend | gpt-6-astra |
| 雷霆 | 后端开发 | backend | claude-fable-5-1 |
| 瑾瑜 | 测试工程师 | qa | grok-4.6 |

## 角色边界

- **指挥官**：任务分解、调度协调（不写代码）
- **产品经理**：需求分析、优先级（不写代码、不做架构）
- **设计师**：界面设计、交互设计（不写前端代码）
- **架构师**：架构设计、技术选型（不写功能代码）
- **前端开发**：前端实现（不改设计稿）
- **后端开发**：后端实现（不做界面）
- **测试工程师**：测试策略、Bug分析（不写功能代码）

详见 [团队规范](references/team-charter.md)

## 工作流程

```
用户需求 → 指挥官(凌霄)
              ↓
         产品经理(诗韵) + 架构师(墨轩)
              ↓               ↓
         设计师(洛璃)   前后端(星河/雷霆)
              ↓               ↓
                    测试(瑾瑜)
                      ↓
                   交付
```

## 如何使用

### 1. 在群聊中发布任务

在 Hermes Desktop 的「星河开发团队」群聊中：
- `@凌霄-指挥官` - 开始新项目
- `@诗韵-产品经理` - 讨论需求
- `@洛璃-设计师` - 获取设计支持
- `@墨轩-架构师` - 获取架构建议
- `@星河-前端开发` - 前端开发任务
- `@雷霆-后端开发` - 后端开发任务
- `@瑾瑜-测试工程师` - 测试任务

### 2. 直接切换角色对话

```bash
hermes chat --profile orchestrator   # 与指挥官对话
hermes chat --profile pm           # 与产品经理对话
hermes chat --profile designer      # 与设计师对话
hermes chat --profile architect     # 与架构师对话
hermes chat --profile frontend     # 与前端开发对话
hermes chat --profile backend      # 与后端开发对话
hermes chat --profile qa           # 与测试工程师对话
```

### 3. 创建 Kanban 任务

```bash
# 切换到开发团队任务板
hermes kanban boards switch dev-team

# 创建任务
hermes kanban create "新功能开发" --board dev-team

# 查看任务
hermes kanban list
```

## 发布任务的正确方式

### 方式一：在群聊中 @ 成员

```
@凌霄-指挥官 我们需要开发一个用户登录功能
```

指挥官会分解任务并调度各成员执行。

### 方式二：直接与指挥官对话

```
@凌霄-指挥官
需求：用户登录功能
1. 支持邮箱密码登录
2. 支持第三方登录（微信、Google）
3. 需要记住登录状态
```

### 方式三：创建详细需求文档

```
@诗韵-产品经理
请帮我分析以下需求并编写 PRD：
[粘贴需求描述]
```

## 参考文档

- [团队规范](references/team-charter.md) - 完整的角色边界和工作流程
- [团队配置](references/team-config.md) - 详细的技术栈和规范
