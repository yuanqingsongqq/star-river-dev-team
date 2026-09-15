#!/usr/bin/env bash
# ============================================================
# 星河开发团队 - 一键启动/停止脚本
# 用法:
#   ./start-team.sh start    启动全部机器人 + Gateway
#   ./start-team.sh stop     停止全部服务
#   ./start-team.sh status   查看服务状态
#   ./start-team.sh logs <bot>  查看某机器人日志
# ============================================================
set -euo pipefail

BOTS=(orchestrator pm architect designer frontend backend qa)
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"

log() { echo "[$(date '+%H:%M:%S')] $*"; }

is_running() {
  ps aux | grep "hermes_cli.main" | grep -v grep | grep -qE -- "--profile $1 |--open-profile $1 "
}

start() {
  log "=== 启动 Gateway ==="
  hermes gateway start 2>&1 | tail -1 || true
  sleep 3

  log "=== 启动 ${#BOTS[@]} 个机器人服务 ==="
  for bot in "${BOTS[@]}"; do
    if is_running "$bot"; then
      log "  $bot 已在运行 ✓"
    else
      nohup hermes --profile "$bot" serve --host 127.0.0.1 --port 0 \
        > "$HERMES_HOME/profiles/$bot/logs/serve-nohup.log" 2>&1 &
      log "  $bot 已启动 (PID $!)"
      sleep 2
    fi
  done

  log ""
  log "=== 验证 ==="
  for bot in "${BOTS[@]}"; do
    is_running "$bot" && echo "  $bot ✅" || echo "  $bot ❌"
  done
  hermes gateway status 2>&1 | head -1
}

stop() {
  log "=== 停止全部机器人服务 ==="
  for bot in "${BOTS[@]}"; do
    if is_running "$bot"; then
      pkill -f "profile $bot serve" 2>/dev/null || true
      log "  $bot 已停止"
    fi
  done
  # 停掉通过 --open-profile 路由的 default serve 实例
  pkill -f "open-profile (designer|frontend|backend|qa|architect|pm)" 2>/dev/null || true
  log "=== 停止 Gateway ==="
  hermes gateway stop 2>&1 | tail -1 || true
  log "全部服务已停止"
}

status() {
  log "=== 机器人服务状态 ==="
  for bot in "${BOTS[@]}"; do
    is_running "$bot" && echo "  $bot ✅" || echo "  $bot ❌ 未运行"
  done
  log "=== Gateway ==="
  hermes gateway status 2>&1 | head -2
}

case "${1:-status}" in
  start) start ;;
  stop)  stop ;;
  status) status ;;
  logs)  tail -50 "$HERMES_HOME/profiles/${2:-orchestrator}/logs/agent.log" ;;
  *) echo "用法: $0 {start|stop|status|logs <bot>}" ;;
esac
