#!/usr/bin/env bash
# ============================================================
# 星河开发团队 - 一键启动/停止/更新脚本
# 用法:
#   ./start-team.sh start    启动全部机器人 + Gateway
#   ./start-team.sh stop     停止全部服务
#   ./start-team.sh status   查看服务状态
#   ./start-team.sh update   执行 hermes update + 重启全部服务
#   ./start-team.sh restart  重启全部服务（不更新）
#   ./start-team.sh logs <bot>  查看某机器人日志
# ============================================================
set -euo pipefail

BOTS=(orchestrator pm architect designer frontend backend qa)
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
HERMES_AGENT="${HERMES_AGENT:-$HERMES_HOME/hermes-agent}"
LAUNCH_AGENTS="$HOME/Library/LaunchAgents"
GATEWAYS=("ai.hermes.gateway-orchestrator" "ai.hermes.gateway-my-p")

log() { echo "[$(date '+%H:%M:%S')] $*"; }

is_running() {
  ps aux | grep "hermes_cli.main" | grep -v grep | grep -qE -- "--profile $1 |--open-profile $1 "
}

# 确保 hermes-agent 的 git remote 指向可用的 SSH-443 通道（github.com HTTPS 被墙）
ensure_git_remote() {
  if [ -d "$HERMES_AGENT/.git" ]; then
    local cur
    cur=$(cd "$HERMES_AGENT" && git remote get-url origin 2>/dev/null || true)
    if [[ "$cur" == *"ssh://git@ssh.github.com:443"* ]]; then
      log "git remote 已是 SSH-443 通道 ✓"
    else
      log "切换 hermes-agent remote → ssh://git@ssh.github.com:443/..."
      (cd "$HERMES_AGENT" && git remote set-url origin "ssh://git@ssh.github.com:443/NousResearch/hermes-agent.git")
    fi
  fi
}

# 重启单个 launchd 服务（bootout + bootstrap，避免 kickstart -k 挂起）
restart_service() {
  local label="$1" plist="$2"
  if [ ! -f "$plist" ]; then
    log "  ⚠ 跳过 $label（无 plist）"
    return
  fi
  launchctl bootout "gui/$(id -u)/$label" > /dev/null 2>&1 || true
  sleep 2
  launchctl bootstrap "gui/$(id -u)" "$plist" > /dev/null 2>&1 || launchctl load "$plist" > /dev/null 2>&1 || true
  log "  $label 已重启"
}

# 重启全部机器人 + gateway
restart_all() {
  log "=== 重启机器人服务 ==="
  for bot in "${BOTS[@]}"; do
    restart_service "ai.hermes.serve-$bot" "$LAUNCH_AGENTS/ai.hermes.serve-$bot.plist"
  done
  log "=== 重启 Gateway ==="
  for gw in "${GATEWAYS[@]}"; do
    restart_service "$gw" "$LAUNCH_AGENTS/$gw.plist"
  done
  log "等待进程稳定 (15s)..."
  sleep 15
  verify_all
}

# 验证所有服务端口监听
verify_all() {
  echo ""
  log "=== 服务状态 ==="
  for bot in "${BOTS[@]}"; do
    local port
    port=$(grep "listening" "$HERMES_HOME/profiles/$bot/logs/serve.error.log" 2>/dev/null | tail -1 | grep -oE "[0-9]{4,5}$")
    if is_running "$bot"; then
      echo "  $bot ✅ 端口 ${port:-?}"
    else
      echo "  $bot ❌ 未运行"
    fi
  done
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

update() {
  log "=== [1/4] 确保 git remote 可用 ==="
  ensure_git_remote

  log "=== [2/4] 执行 hermes update ==="
  cd "$HERMES_AGENT"
  hermes update || {
    log "⚠ update 未完全完成（可能需补跑），继续尝试重启使其生效"
  }

  log "=== [3/4] 重启全部服务 ==="
  restart_all

  log "=== [4/4] 完成 ==="
  log "hermes update 与服务重启已执行完毕。默认模型/供应商请查看 model-config.md"
}

case "${1:-status}" in
  start) start ;;
  stop)  stop ;;
  status) status ;;
  update) update ;;
  restart) restart_all ;;
  logs)  tail -50 "$HERMES_HOME/profiles/${2:-orchestrator}/logs/agent.log" ;;
  *) echo "用法: $0 {start|stop|status|update|restart|logs <bot>}" ;;
esac
