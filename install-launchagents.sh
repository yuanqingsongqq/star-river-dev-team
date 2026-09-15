#!/usr/bin/env bash
# ============================================================
# 为 7 个机器人创建 launchd LaunchAgent（开机自启 + 崩溃自动重启）
# 用法: ./install-launchagents.sh [install|uninstall|status]
# ============================================================
set -euo pipefail

BOTS=(orchestrator pm architect designer frontend backend qa)
HERMES_BIN="$HOME/.hermes/hermes-agent/venv/bin/python"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
STDERR_HELPER="$HOME/.hermes/hermes-agent/venv/bin/python -m hermes_cli.stderr_timestamp"
VENV_PATH="$HOME/.hermes/hermes-agent/venv"

make_plist() {
  local bot="$1"
  local plist="$LAUNCH_AGENTS_DIR/ai.hermes.serve-$bot.plist"
  cat > "$plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>ai.hermes.serve-$bot</string>

    <key>ProgramArguments</key>
    <array>
        <string>$HERMES_BIN</string>
        <string>-m</string>
        <string>hermes_cli.stderr_timestamp</string>
        <string>--error-log</string>
        <string>$HOME/.hermes/profiles/$bot/logs/serve.error.log</string>
        <string>--</string>
        <string>$HERMES_BIN</string>
        <string>-m</string>
        <string>hermes_cli.main</string>
        <string>--profile</string>
        <string>$bot</string>
        <string>serve</string>
        <string>--host</string>
        <string>127.0.0.1</string>
        <string>--port</string>
        <string>0</string>
    </array>

    <key>WorkingDirectory</key>
    <string>$HOME/.hermes/profiles/$bot</string>

    <key>EnvironmentVariables</key>
    <dict>
        <key>PATH</key>
        <string>$VENV_PATH/bin:/Users/yuanqingsong/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
        <key>VIRTUAL_ENV</key>
        <string>$VENV_PATH</string>
        <key>HERMES_HOME</key>
        <string>$HOME/.hermes/profiles/$bot</string>
        <key>HERMES_SUPERVISED_CHILD</key>
        <string>1</string>
    </dict>

    <key>LimitLoadToSessionType</key>
    <array>
        <string>Aqua</string>
        <string>Background</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>ThrottleInterval</key>
    <integer>30</integer>

    <key>ExitTimeOut</key>
    <integer>15</integer>

    <key>SoftResourceLimits</key>
    <dict>
        <key>NumberOfFiles</key>
        <integer>4096</integer>
    </dict>

    <key>StandardOutPath</key>
    <string>$HOME/.hermes/profiles/$bot/logs/serve.log</string>

    <key>StandardErrorPath</key>
    <string>$HOME/.hermes/profiles/$bot/logs/serve.error.log</string>
</dict>
</plist>
PLIST
}

install() {
  mkdir -p "$LAUNCH_AGENTS_DIR"
  # 先停掉手动 nohup 的旧进程，避免冲突
  echo "=== 停止手动启动的进程 ==="
  for bot in "${BOTS[@]}"; do
    pkill -f "profile $bot serve" 2>/dev/null || true
    pkill -f "open-profile $bot" 2>/dev/null || true
  done
  sleep 2

  echo "=== 生成并加载 LaunchAgent ==="
  for bot in "${BOTS[@]}"; do
    make_plist "$bot"
    launchctl unload "$LAUNCH_AGENTS_DIR/ai.hermes.serve-$bot.plist" 2>/dev/null || true
    launchctl load "$LAUNCH_AGENTS_DIR/ai.hermes.serve-$bot.plist"
    echo "  ✅ $bot 已注册 launchd"
  done
  echo "完成"
}

uninstall() {
  echo "=== 卸载 LaunchAgent ==="
  for bot in "${BOTS[@]}"; do
    local plist="$LAUNCH_AGENTS_DIR/ai.hermes.serve-$bot.plist"
    launchctl unload "$plist" 2>/dev/null || true
    rm -f "$plist"
    echo "  ✅ $bot 已移除"
  done
}

status() {
  echo "=== launchd 服务状态 ==="
  for bot in "${BOTS[@]}"; do
    if launchctl list | grep -q "ai.hermes.serve-$bot"; then
      echo "  $bot ✅ 已注册并运行"
    else
      echo "  $bot ❌ 未注册"
    fi
  done
}

case "${1:-status}" in
  install) install ;;
  uninstall) uninstall ;;
  status) status ;;
  *) echo "用法: $0 {install|uninstall|status}" ;;
esac
