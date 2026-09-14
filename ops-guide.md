# 星河开发团队 - 运维手册（会话语柄锁问题）

> **更新日期**: 2026-09-14
> **适用范围**: Hermes 桌面端 + 多 Profile（机器人）协作场景

---

## 一、问题现象

某个机器人（如后端开发）在桌面端发消息后**一直不回复**，但：

- 模型 API 直连测试是通的
- 命令行 `hermes -p <bot> -z "..."` 能正常回复
- 只是桌面端里那个会话没反应

---

## 二、根因分析

### 2.1 本质：会话语柄（lease）被其他进程锁住

```
后端会话 20260910_182822_c2a1d0
        ↓
被 PID 94941（PM 的 serve 进程）的 lease 持有
        ↓
后端进程尝试接管 → Refused: already held by pid=94941
        ↓
消息进不去 → 机器人"不回复"
```

日志关键证据：

```
INFO hermes_cli.active_sessions: Refused active session <会话ID>: already held by pid=<PID> surface=desktop
```

### 2.2 为什么会发生

| 因素 | 说明 |
|------|------|
| 桌面端长驻进程 | 一个 serve 进程从开机跑到深夜（如 PM 进程跑了 21 小时） |
| 多会话共用进程 | 桌面端把多个机器人的会话都路由到同一进程 |
| lease 不释放 | 只要持有进程活着，lease 永不过期，Hermes 内置清理（Pruned stale lease）只对**已死进程**生效 |

### 2.3 伴随风险

- 巨型会话上下文（200K+ tokens）会叠加 30~60 秒延迟，更容易触发备用模型与超时
- 群聊场景下多个机器人会话挤在同一进程，锁风险更高

---

## 三、预防措施

### 3.1 每日操作习惯（最重要）

1. **用完即关**：切换/用完某个机器人后，关闭它的会话窗口，释放 lease
2. **不要长期悬挂**：不用的机器人会话及时关闭，别挂在后台
3. **每日重启**：当天结束时完全退出桌面端，让所有 lease 清空；第二天重新打开
4. **群聊节制**：群聊机器人会话上下文膨胀快，避免长期开启多机器人群聊

### 3.2 配置层面

- 每个机器人的 profile 独立配置 `providers`，默认/备用模型固定写在配置里
- 已关闭 `discover_models`，避免运行时动态覆盖模型列表
- 供应商名称避免使用会触发 Hermes 别名的名称（如 `claude` 会被当成 Anthropic，导致模型名 `glm-5.2` 被转成 `glm-5-2` 而 404）

---

## 四、故障处理流程

### 情况 A：某机器人不回复（无报错）

```bash
# 1. 查看进程
ps aux | grep "profile <机器人>" | grep -v grep

# 2. 查看是否有 lease 冲突日志
grep -E "Refused active session|Preserving session|live owner" \
  ~/.hermes/profiles/<机器人>/logs/agent.log | tail -10

# 3. 令机器人进程重启（强制释放旧 lease）
pkill -f "profile <机器人> serve"

# 4. 桌面端关闭该机器人的旧会话窗口，新建对话
```

### 情况 B：重启后仍不回复

```bash
# 1. 检查是否还有"幽灵"进程占用
ps aux | grep hermes_cli.main | grep -v grep

# 2. 确认模型可用（直连测试）
source ~/.hermes/profiles/<机器人>/.env
curl -s -X POST "<base_url>/v1/chat/completions" \
  -H "Authorization: Bearer $<KEY_ENV>" \
  -H "Content-Type: application/json" \
  -d '{"model":"<默认模型>","messages":[{"role":"user","content":"回复OK"}],"max_tokens":10}'

# 3. 若进程健康但仍有锁，清理 lease
hermes sessions list   # 找到卡住的会话
# 在桌面端删除该会话，或 hermes -p <机器人> chat 新建会话
```

### 情况 C：响应极慢（30~60 秒以上）

大概率是**巨型会话上下文**（100K+ tokens）：

```bash
# 确认上下文大小
grep "conversation_loop" ~/.hermes/profiles/<机器人>/logs/agent.log | tail -3
# 若 in= 字段为 6-7 位数以上，会话确实过大
```

解决：归档/删除巨型会话，或新建对话。

---

## 五、快速验证命令

| 目的 | 命令 |
|------|------|
| 测试模型是否通 | `hermes -p <机器人> -z "请只回复两个字：收到"` |
| 查看进程 | `ps aux \| grep "profile <机器人>" \| grep -v grep` |
| 查看日志 | `tail -30 ~/.hermes/profiles/<机器人>/logs/agent.log` |
| 查看错误 | `tail -20 ~/.hermes/profiles/<机器人>/logs/errors.log` |
| 查看会话 | `hermes sessions list` |

---

## 六、常见问答

**Q1：为什么模型直连能通，桌面端却不回？**
A：模型层通的，问题是会话 lease 被其他进程锁住，消息进不到模型调用环节。

**Q2：Hermes 不是会自动清理 stale lease 吗？**
A：会，但只清理**持有进程已死**的 lease。只要持有进程活着（哪怕闲置 20 小时），lease 就不会被清理。

**Q3：为什么供应商/模型升级后总会变样？**
A：主要是三个原因：① Hermes 更新触发配置迁移重写；② `discover_models: true` 依赖供应商动态列表；③ 供应商名称触发 Hermes 别名规范化。预防：写死 providers、关闭 discover_models、避免触发别名的命名。