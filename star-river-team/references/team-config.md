# 星河开发团队 - 详细配置

## 模型配置

| 中文名 | 岗位 | 模型 | 供应商 |
|--------|------|------|--------|
| 凌霄 | 指挥官 | claude-fable-5-1 | Claude |
| 诗韵 | 产品经理 | glm-5.3 | 智谱 |
| 洛璃 | 设计师 | kimi-k3 | Kimi |
| 墨轩 | 架构师 | claude-fable-5-1 | Claude |
| 星河 | 前端开发 | gpt-6-astra | GPT |
| 雷霆 | 后端开发 | claude-fable-5-1 | Claude |
| 瑾瑜 | 测试工程师 | grok-4.6 | Grok |

## 技术栈参考

### 后端
- Java + Spring Boot
- Node.js + NestJS
- Python + FastAPI
- Go + Gin

### 前端
- React + TypeScript
- Vue 3 + TypeScript
- Next.js / Nuxt.js

### 数据库
- PostgreSQL (首选)
- MySQL
- MongoDB
- Redis

### 工具
- Vite / Webpack
- Tailwind CSS
- Zustand / Pinia
- Vitest / Playwright

## 代码规范

### 前端
- TypeScript strict mode
- 组件文件 < 200 行
- 优先使用 Tailwind
- Hooks 命名以 use 开头

### 后端
- RESTful API 设计
- 分层架构 (Controller/Service/Repository)
- 统一响应格式
- 完善的错误处理

## 质量标准

### 前端
- Lighthouse 性能 ≥ 90
- 无 console error
- E2E 测试覆盖关键路径
- WCAG 2.1 AA 可访问性

### 后端
- API 响应 < 200ms (P95)
- 集成测试覆盖
- 无安全漏洞

### 测试
- 覆盖率 ≥ 80%
- 无 P0/P1 Bug
- 回归测试 100% 通过
