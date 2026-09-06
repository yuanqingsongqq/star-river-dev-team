# 架构设计技能

## 触发场景

当需要以下任务时使用此技能：
- 系统架构设计
- 技术选型
- API 设计
- 数据库设计
- 架构评审

## 核心能力

### 1. 架构设计文档模板

```markdown
# 架构设计文档 - {系统名称}

## 1. 概述

### 1.1 背景
[为什么需要这个系统]

### 1.2 目标
[系统要达到的目标]

### 1.3 范围
- **包含**：
- **不包含**：

## 2. 系统架构

### 2.1 整体架构图
```
┌─────────────────────────────────────┐
│            客户端层                  │
│  (Web / iOS / Android / 小程序)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│            网关层                    │
│     (API Gateway / Nginx)            │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│            服务层                    │
│  ┌─────────┐  ┌─────────┐        │
│  │ 服务 A   │  │ 服务 B   │        │
│  └────┬────┘  └────┬────┘        │
│       │              │               │
│  ┌────▼────┐  ┌────▼────┐        │
│  │ 缓存层  │  │ 消息队列│        │
│  └────┬────┘  └────┬────┘        │
└──────────────┼──────────────┬─────────┘
               │              │
┌──────────────▼──────────────▼─────────┐
│            数据层                      │
│  ┌─────────┐  ┌─────────┐          │
│  │ PostgreSQL │  │ MongoDB  │          │
│  └─────────┘  └─────────┘          │
└─────────────────────────────────────┘
```

### 2.2 模块划分
| 模块 | 职责 | 技术栈 | 负责人 |
|------|------|--------|--------|
| gateway | 路由、鉴权 | Nginx | ... |
| service-a | 业务逻辑 | Spring Boot | ... |
| ... | ... | ... | ... |

## 3. API 设计

### 3.1 接口规范
```markdown
## RESTful 规范
- 资源命名：/api/{资源名}
- HTTP 方法：GET/POST/PUT/DELETE
- 版本控制：/api/v1/users
```

### 3.2 接口列表
| 方法 | 路径 | 描述 | 优先级 |
|------|------|------|--------|
| GET | /api/v1/users | 获取用户列表 | P0 |
| POST | /api/v1/users | 创建用户 | P0 |
| GET | /api/v1/users/{id} | 获取用户详情 | P0 |
```

### 3.3 数据模型
```typescript
// 用户模型
interface User {
  id: string;           // UUID
  name: string;         // 姓名
  email: string;         // 邮箱
  phone?: string;        // 手机号
  status: UserStatus;    // 状态
  createdAt: Date;       // 创建时间
  updatedAt: Date;       // 更新时间
}

enum UserStatus {
  ACTIVE = 'active',
  INACTIVE = 'inactive',
  DELETED = 'deleted'
}
```

## 4. 数据库设计

### 4.1 ER 图
[实体关系图]

### 4.2 表结构
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20),
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_status ON users(status);
```

## 5. ADR (架构决策记录)

### ADR-001: 选择 PostgreSQL
**状态**：已接受
**背景**：需要支持复杂查询、事务、JSON
**决策**：使用 PostgreSQL 15
**后果**：
- ✅ 支持 JSONB、全文搜索
- ✅ 成熟稳定
- ❌ 需要额外运维

## 6. 技术风险
| 风险 | 影响 | 概率 | 应对 |
|------|------|------|------|
| 数据量增长 | 高 | 中 | 分库分表 |
| 并发增加 | 中 | 高 | 水平扩展 |
```
