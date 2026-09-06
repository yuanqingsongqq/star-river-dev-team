# 🌟 星河开发团队 (Star River Development Team)

> 基于 Hermes Agent 构建的 AI 软件开发团队

## 📖 项目简介

**星河开发团队**是一个基于 [Hermes Agent](https://github.com/AtlasOmega/hermes-agent) 构建的专业 AI 软件开发团队。由 7 个各具特色的 AI Agent 组成，每个成员都有明确的岗位职责、边界规则和专属模型配置。

### 团队理念

```
我们是一个由 AI Agent 组成的专业软件开发团队。

每个成员都有明确的角色定位，专业技能和责任边界。
我们通过标准化的流程和清晰的文档传递协作，
共同交付高质量的软件产品。
```

---

## 👥 团队成员

| 中文名 | 岗位 | Profile | 默认模型 | 供应商 |
|--------|------|---------|----------|--------|
| **凌霄** | 指挥官 | orchestrator | claude-fable-5-1 | Claude |
| **诗韵** | 产品经理 | pm | glm-5.3 | 智谱 |
| **洛璃** | 设计师 | designer | kimi-k3 | Kimi |
| **墨轩** | 架构师 | architect | claude-fable-5-1 | Claude |
| **星河** | 前端开发 | frontend | gpt-6-astra | GPT |
| **雷霆** | 后端开发 | backend | claude-fable-5-1 | Claude |
| **瑾瑜** | 测试工程师 | qa | grok-4.6 | Grok |

### 成员头像

<div align="center">

| 凌霄-指挥官 | 诗韵-产品经理 | 洛璃-设计师 |
|:---:|:---:|:---:|
| <img src="avatars/orchestrator-avatar.png" width="120"> | <img src="avatars/pm-avatar.png" width="120"> | <img src="avatars/designer-avatar.png" width="120"> |

| 墨轩-架构师 | 星河-前端开发 | 雷霆-后端开发 | 瑾瑜-测试工程师 |
|:---:|:---:|:---:|:---:|
| <img src="avatars/architect-avatar.png" width="120"> | <img src="avatars/frontend-avatar.png" width="120"> | <img src="avatars/backend-avatar.png" width="120"> | <img src="avatars/qa-avatar.png" width="120"> |

</div>

---

## 🎯 角色职责

### 指挥官 (凌霄) 🤖
**任务分解与调度协调**

- ✅ 任务分解与规划
- ✅ 团队协调与调度
- ✅ 进度监控与交付
- ❌ 不写代码、不做设计

### 产品经理 (诗韵) 📋
**需求分析与优先级**

- ✅ 需求分析与调研
- ✅ 用户故事编写
- ✅ 验收标准定义
- ✅ 优先级排序
- ❌ 不写代码、不做架构设计

### UI/UX设计师 (洛璃) 🎨
**界面设计与交互设计**

- ✅ 界面视觉设计
- ✅ 交互流程设计
- ✅ 设计系统维护
- ✅ 用户体验优化
- ❌ 不写前端代码

### 架构师 (墨轩) 🏗️
**系统架构与技术选型**

- ✅ 系统架构设计
- ✅ 技术选型决策
- ✅ API 接口设计
- ✅ 数据库设计
- ❌ 不写具体功能代码

### 前端开发 (星河) 💻
**界面开发与组件实现**

- ✅ 前端界面开发
- ✅ 组件库建设
- ✅ API 集成对接
- ✅ 性能优化
- ❌ 不修改设计稿、不写后端逻辑

### 后端开发 (雷霆) ⚙️
**API开发与业务逻辑**

- ✅ 业务逻辑实现
- ✅ API 接口开发
- ✅ 数据库开发
- ✅ 服务部署维护
- ❌ 不写前端界面、不做 UI 设计

### 测试工程师 (瑾瑜) 🔍
**测试策略与质量把关**

- ✅ 测试策略制定
- ✅ 测试用例编写
- ✅ Bug 追踪管理
- ✅ 质量评估报告
- ❌ 不写功能代码

---

## 🔄 工作流程

```
┌─────────────────────────────────────────────────────────────┐
│                      开发流程图                             │
└─────────────────────────────────────────────────────────────┘

   用户需求
      ↓
   凌霄 (指挥官) ← 任务分解与调度
      ↓
   ┌────┴────┐
   ↓         ↓
诗韵(PM)  墨轩(架构)
   ↓         ↓
   └────┬────┘
        ↓
   ┌────┴────┐
   ↓         ↓
洛璃(设计) 星河/雷霆(开发)
   ↓         ↓
   └────┬────┘
        ↓
   瑾瑜 (QA)
        ↓
   凌霄 (交付)
```

---

## 📁 项目结构

```
star-river-dev-team/
├── README.md                    # 本文件
├── LICENSE                     # MIT 许可证
├── AGENTS.md                  # 团队协作规则
├── team-charter.md            # 团队章程
├── team.yaml                  # 团队配置
├── avatars/                   # 成员头像
│   ├── orchestrator-avatar.png
│   ├── pm-avatar.png
│   ├── designer-avatar.png
│   ├── architect-avatar.png
│   ├── frontend-avatar.png
│   ├── backend-avatar.png
│   └── qa-avatar.png
├── profiles/                  # Profile 配置
│   ├── orchestrator/
│   │   ├── SOUL.md          # 角色定义
│   │   ├── USER.md          # 身份信息
│   │   ├── config.yaml      # 模型配置
│   │   └── profile.yaml     # 显示名称
│   ├── pm/
│   ├── designer/
│   ├── architect/
│   ├── frontend/
│   ├── backend/
│   └── qa/
└── star-river-team/           # Hermes Skill
    ├── SKILL.md              # 使用指南
    └── references/            # 参考文档
        ├── team-charter.md
        └── team-config.md
```

---

## 🚀 快速开始

### 1. 安装 Hermes Agent

```bash
# macOS
brew install hermes-agent

# 或参考官方文档
# https://hermes-agent.nousresearch.com
```

### 2. 创建团队 Profile

```bash
# 创建所有 Profile
hermes profile create orchestrator
hermes profile create pm
hermes profile create designer
hermes profile create architect
hermes profile create frontend
hermes profile create backend
hermes profile create qa
```

### 3. 复制配置

```bash
# 复制 SOUL.md, USER.md, config.yaml, profile.yaml 到对应 Profile 目录
# 参考 profiles/ 目录下的配置
```

### 4. 与团队对话

```bash
# 与指挥官开始项目
hermes chat --profile orchestrator

# 与产品经理讨论需求
hermes chat --profile pm

# 与设计师沟通设计
hermes chat --profile designer
```

### 5. 使用 Kanban 任务板

```bash
# 切换到开发团队任务板
hermes kanban boards switch dev-team

# 创建任务
hermes kanban create "用户登录功能" --board dev-team

# 查看任务
hermes kanban list
```

---

## 📝 在群里发布任务

### 方式一：@ 指挥官发布需求

```
@凌霄-指挥官 我们需要开发一个用户登录功能

功能要求：
1. 邮箱 + 密码登录
2. 第三方登录（微信、Google）
3. 记住登录状态
4. 忘记密码功能
```

### 方式二：@ 特定成员

```
@诗韵-产品经理 请帮我分析这个需求...
@墨轩-架构师 这个技术方案可行吗...
@洛璃-设计师 需要设计一个登录页面...
@星河-前端开发 按这个设计稿实现...
@雷霆-后端开发 按这个 API 文档开发...
@瑾瑜-测试工程师 测试这个功能...
```

---

## 🛠️ 模型配置说明

### 供应商分布

| 供应商 | 模型 | 分配角色 |
|--------|------|----------|
| **Claude** | claude-fable-5-1 | 指挥官、架构师、后端 (3人) |
| **GPT** | gpt-6-astra | 前端开发 |
| **智谱** | glm-5.3 | 产品经理 |
| **Kimi** | kimi-k3 | 设计师 |
| **Grok** | grok-4.6 | 测试工程师 |

### 配置示例 (config.yaml)

```yaml
model:
  default: claude-fable-5-1
  provider: cc-unlimited
  base_url: https://rsxermu666.cn/v1
  key_env: CCC_API_KEY
```

---

## 📚 相关文档

- [团队协作规则](AGENTS.md) - 详细的协作规范和边界规则
- [团队章程](team-charter.md) - 完整的角色边界和工作流程
- [团队配置](team.yaml) - YAML 格式的团队配置

---

## 📄 License

MIT License - 详见 [LICENSE](LICENSE) 文件

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

<p align="center">
  <strong>Made with ❤️ by Star River Development Team</strong>
  <br>
  基于 Hermes Agent 构建
</p>
