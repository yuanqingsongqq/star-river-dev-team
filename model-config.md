# 星河开发团队 - 模型配置
# 更新日期: 2026-09-07

---

## 一、团队成员模型配置

| 中文名 | 岗位 | Profile | 主模型 | 供应商 | 备用模型 |
|--------|------|---------|--------|--------|----------|
| 凌霄 | 指挥官 | orchestrator | claude-fable-5-1 | cc-unlimited | claude-sonnet-4-6 |
| 文远 | 产品经理 | pm | glm-5.3 | claude | glm-5.2 |
| 墨渊 | 架构师 | architect | claude-fable-5-1 | cc-unlimited | claude-sonnet-4-6 |
| 瑶光 | UI/UX设计师 | designer | kimi-k3 | claude | glm-5.3 |
| 承影 | 前端开发工程师 | frontend | gpt-6-astra | codex200 | gpt-5.6-sol |
| 破军 | 后端开发工程师 | backend | claude-fable-5-1 | cc-unlimited | grok-4.6 |
| 天枢 | 测试工程师 | qa | kimi-k3 | claude | glm-5.3 |

---

## 二、供应商配置详情

### 2.1 cc-unlimited

| 配置项 | 值 |
|--------|-----|
| Base URL | https://rsxermu666.cn/v1 |
| Key Env | CCC_API_KEY |
| Transport | chat_completions |
| 模型列表 | claude-fable-5-1, claude-sonnet-4-6 (1M), claude-opus-4-8, grok-4.6, kimi-k3, glm-5.3 |

### 2.2 claude (GLM/Kimi)

| 配置项 | 值 |
|--------|-----|
| Base URL | https://llm.goaichat.top/v1 |
| Key Env | GLM_API_KEY |
| Transport | chat_completions |
| 模型列表 | glm-5.3, glm-5.2, kimi-k2.6, kimi-k2.7-code, kimi-k3 |

### 2.3 codex200

| 配置项 | 值 |
|--------|-----|
| Base URL | https://www.kldai.cc/v1 |
| Key Env | CODEX200_API_KEY |
| Transport | chat_completions |
| 模型列表 | gpt-6-astra, gpt-5.5, gpt-5.6-sol, gpt-5.6-terra |

### 2.4 grok1

| 配置项 | 值 |
|--------|-----|
| Base URL | https://api.cheng.pink/v1 |
| Key Env | GROK1_API_KEY |
| Transport | chat_completions |
| 模型列表 | grok-4.6, grok-4.5 |

---

## 三、模型选择依据

| 成员 | 角色定位 | 模型选择依据 |
|------|----------|--------------|
| 凌霄 | 核心决策、任务协调 | 需要最强推理能力 |
| 文远 | 需求分析、文档撰写 | 需要中文理解 + 性价比 |
| 墨渊 | 技术设计、系统规划 | 需要最强推理能力 |
| 瑶光 | UI/UX、创意设计 | 需要中文理解 + 创意能力 |
| 承影 | 页面开发、交互实现 | 代码能力优先 |
| 破军 | API开发、业务逻辑 | 需要最强推理能力 |
| 天枢 | 测试验证、质量把控 | 需要分析能力 |

---

## 四、备用模型配置逻辑

| 成员 | 主模型 | 备用模型 | 备用原因 |
|------|--------|----------|----------|
| 凌霄 | claude-fable-5-1 | claude-sonnet-4-6 | 同系列，能力接近 |
| 文远 | glm-5.3 | glm-5.2 | 同系列，备用 |
| 墨渊 | claude-fable-5-1 | claude-sonnet-4-6 | 同系列，备用 |
| 瑶光 | kimi-k3 | glm-5.3 | 同类模型，中文支持 |
| 承影 | gpt-6-astra | gpt-5.6-sol | 同系列，备用 |
| 破军 | claude-fable-5-1 | grok-4.6 | 不同模型，增加多样性 |
| 天枢 | grok-4.6 | grok-4.5 | 同系列，备用 |

---

## 五、飞书集成配置

| 配置项 | 值 |
|--------|-----|
| App ID | cli_aa173ecab2b89cdb |
| 连接方式 | WebSocket 长连接 |
| 主频道 | 需设置 /sethome |
| 配对 | 首次使用需配对认证 |

---

## 六、Kanban 看板配置

| 看板 | 用途 | 成员 |
|------|------|------|
| star-river-team | 星河开发团队（综合） | 所有成员 |
| star-river-core | 星河核心组 | 指挥官、PM、架构师、设计师、前端、后端 |
| star-river-qa | 星河质量组 | QA、指挥官、PM、后端 |

---

**最后更新**: 2026-09-07
