# Cron 定时任务配置

## 定时任务清单

| 任务名称 | 执行时间 | Profile | 说明 |
|---------|---------|---------|------|
| 每日站会 | 工作日 9:00 | orchestrator | 汇总昨日进展和今日计划 |
| 每日设计检视 | 工作日 10:00 | designer | 检查设计稿进度 |
| 每日开发同步 | 工作日 10:30 | architect | 检查架构文档进度 |
| 每周周报 | 周五 17:00 | orchestrator | 生成项目周报 |
| 每月回顾 | 每月最后一天 | orchestrator | 项目月度总结 |

## 创建 Cron 任务

```bash
# 每日站会提醒
hermes cron create "0 9 * * 1-5" \
  --name "每日站会提醒" \
  --profile orchestrator \
  --prompt "提醒团队成员：
1. 汇报昨日进展（完成的任务、产出的交付物）
2. 汇报今日计划（计划做的事情）
3. 提出遇到的阻塞和问题

请将汇报整理成结构化格式，包括：任务名、状态、阻塞问题（如有）"

# 每日设计检视
hermes cron create "0 10 * * 1-5" \
  --name "设计进度检视" \
  --profile designer \
  --prompt "检视当前设计任务进度：
1. 检查是否有待处理的设计需求
2. 检查设计稿是否有开发反馈需要响应
3. 如有问题，在设计文档中标注并通知相关方"

# 每日开发同步
hermes cron create "0 10 30 * * 1-5" \
  --name "架构文档检视" \
  --profile architect \
  --prompt "检视架构工作进度：
1. 检查是否有待评审的架构方案
2. 检查 API 文档是否需要更新
3. 如有问题，在架构文档中标注并通知相关方"

# 每周周报
hermes cron create "0 17 * * 5" \
  --name "项目周报生成" \
  --profile orchestrator \
  --prompt "生成项目周报：
1. 汇总本周完成的任务和交付物
2. 汇总下周计划
3. 列出未解决的阻塞问题
4. 评估本周进度是否符合预期

格式要求：
- 本周完成
- 下周计划
- 阻塞问题
- 进度评估"

# 每月回顾
hermes cron create "0 17 28-31 * *" \
  --name "月度项目回顾" \
  --profile orchestrator \
  --prompt "如果今天是月末，执行月度回顾：
1. 汇总本月完成的主要里程碑
2. 统计团队产出（代码量、文档数、任务数）
3. 回顾遇到的问题和解决方案
4. 制定下月计划

如果今天不是月末，跳过执行。"
```

## 查看 Cron 任务

```bash
hermes cron list
```

## 管理 Cron 任务

```bash
# 暂停任务
hermes cron pause <任务名>

# 恢复任务
hermes cron resume <任务名>

# 删除任务
hermes cron rm <任务名>

# 手动执行一次
hermes cron run <任务名>
```

## 注意事项

1. **Cron ticker 需要 Gateway 运行**
   ```bash
   hermes gateway restart
   ```

2. **Profile 需要在运行状态才能执行**
   确保对应的 Profile 已启动

3. **任务输出会发送到配置的频道**
   可以在 prompt 中指定输出方式
