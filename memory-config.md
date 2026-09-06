# 增强记忆配置

## 当前状态

Mem0 (向量记忆) 已启用：
```yaml
mcp_servers:
  '@modelcontextprotocol/server-memory':
    enabled: true
```

## 增强配置方案

### 1. 每个 Profile 的 MEMORY.md

为每个角色配置独立的长期记忆文件：

```markdown
# MEMORY.md - {角色名}

## 专业领域
[记录该角色的专业知识和经验]

## 常用模板
[记录常用的工作模板]

## 偏好设置
[记录工作偏好和习惯]

## 项目经验
[记录参与过的项目及其特点]

## 注意事项
[记录需要特别注意的事项]
```

### 2. 配置示例

```bash
# 为每个 Profile 创建 MEMORY.md
for p in orchestrator pm designer architect frontend backend qa; do
  cat > ~/.hermes/profiles/$p/MEMORY.md << 'EOF'
# MEMORY.md

## 专业领域
[待填写]

## 常用模板
[待填写]

## 项目经验
[待填写]

## 注意事项
[待填写]
EOF
done
```

### 3. USER.md 配置

每个 Profile 的 USER.md 应该包含：

```markdown
# USER.md

## 身份信息
- 中文名：{名字}
- 岗位：{职位}
- Profile：{profile名}

## 专业背景
[专业经验和技术栈]

## 工作偏好
[工作习惯和偏好]

## 长期目标
[职业发展目标]
```

## 向量记忆配置 (Mem0)

### 启用 Mem0

```bash
# Mem0 已通过 MCP server 启用
# 检查状态
hermes doctor memory 2>&1
```

### 使用 Mem0

在对话中自然使用：

```
记住这个：用户偏好深色模式，界面使用 12px 字体

之前讨论的架构方案是：微服务架构
```

### 查询记忆

```
之前我们讨论过的 API 设计规范是什么？
我记住的用户登录流程是什么？
```

## 团队共享知识库

### 创建团队知识库目录

```bash
mkdir -p ~/.hermes/profiles/shared/knowledge
```

### 知识库结构

```
knowledge/
├── products/           # 产品知识
│   └── [产品名]/
├── projects/           # 项目知识
│   └── [项目名]/
├── patterns/           # 最佳实践
│   ├── architecture/
│   ├── frontend/
│   └── backend/
└── decisions/         # 决策记录
    └── [ADR文件]
```

### 知识共享规则

1. **每个角色的专业知识** → 记录在对应 Profile
2. **团队共享知识** → 记录在 shared/knowledge
3. **重要决策** → 记录在 decisions/

## 记忆维护

### 定期清理

```bash
# 每月清理一次过期记忆
hermes memory gc
```

### 记忆同步

```bash
# 导出记忆
hermes memory export > backup/memory-$(date +%Y%m).json

# 导入记忆
hermes memory import backup/memory-xxx.json
```
