# 前端开发技能

## 触发场景

当需要以下任务时使用此技能：
- React/Vue 组件开发
- TypeScript 类型定义
- CSS/样式开发
- 性能优化
- 代码审查

## 核心能力

### 1. React 组件模板

```typescript
import React, { useState, useEffect } from 'react';
import { Button } from '@/components/ui';
import type { User } from '@/types';

// Props 类型定义
interface UserCardProps {
  user: User;
  onEdit?: (id: string) => void;
  onDelete?: (id: string) => void;
  /** 是否禁用 */
  disabled?: boolean;
}

// 组件实现
export const UserCard: React.FC<UserCardProps> = ({
  user,
  onEdit,
  onDelete,
  disabled = false,
}) => {
  const [loading, setLoading] = useState(false);

  const handleEdit = () => {
    onEdit?.(user.id);
  };

  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <div className="actions">
        <Button onClick={handleEdit} disabled={disabled || loading}>
          编辑
        </Button>
        <Button variant="danger" onClick={() => onDelete?.(user.id)}>
          删除
        </Button>
      </div>
    </div>
  );
};
```

### 2. TypeScript 规范

```typescript
// 基础类型
type ID = string;
type Timestamp = number;
type Nullable<T> = T | null;

// 枚举
enum Status {
  Active = 'active',
  Inactive = 'inactive',
}

// 接口
interface User {
  id: ID;
  name: string;
  email: string;
  status: Status;
  createdAt: Timestamp;
}

// 联合类型
type UserRole = 'admin' | 'user' | 'guest';

// 函数类型
type UserService = {
  getUser: (id: ID) => Promise<User>;
  updateUser: (id: ID, data: Partial<User>) => Promise<User>;
};
```

### 3. CSS 规范 (Tailwind)

```html
<!-- 布局 -->
<div class="flex items-center justify-between gap-4">
  
<!-- 响应式 -->
<div class="w-full md:w-1/2 lg:w-1/3">
  
<!-- 状态 -->
<button class="hover:bg-blue-500 focus:ring-2 disabled:opacity-50">
  
<!-- 暗色模式 -->
<div class="bg-white dark:bg-gray-900">
```

### 4. 目录结构

```
src/
├── components/           # 通用组件
│   ├── ui/              # UI 基础组件
│   │   ├── Button/
│   │   ├── Input/
│   │   └── Card/
│   └── layout/          # 布局组件
├── features/            # 功能模块
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── api/
│   │   └── index.ts
│   └── dashboard/
├── hooks/               # 自定义 Hooks
├── utils/               # 工具函数
├── types/               # 类型定义
├── api/                 # API 客户端
└── pages/               # 页面组件
```

### 5. 代码审查清单

- [ ] Props 有完整的 TypeScript 类型
- [ ] 组件有 Props 文档注释
- [ ] 有对应的测试文件
- [ ] 没有使用 any 类型
- [ ] 遵循命名规范
- [ ] 样式使用 Tailwind
- [ ] 有 loading/error 状态处理
- [ ] 符合可访问性规范
```
