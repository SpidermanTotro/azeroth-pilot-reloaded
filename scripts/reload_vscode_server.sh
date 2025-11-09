#!/usr/bin/env bash
set -euxo pipefail

echo "== Stop any running VS Code server processes =="
pkill -f vscode-server || true
# Best-effort: kill any vscode-remote / vscode-server related node processes by pattern
# Use a quoted pattern to avoid shell metacharacter issues
pkill -f 'vscode-remote|vscode-server' || true

echo "== Detect and back up remote server dirs =="
for d in "$HOME/.vscode-remote" "$HOME/.vscode-server"; do
  if [ -d "$d" ]; then
    ts=$(date +%s)
    echo "Backing up $d -> ${d}.bak.$ts"
    mv "$d" "${d}.bak.$ts"
  fi
done

echo "== Trim extension cache only (leave your project intact) =="
# If you want to keep extensions, comment out this block.
for d in "$HOME/.vscode-remote/extensions" "$HOME/.vscode-server/extensions"; do
  if [ -d "$d" ]; then
    ts=$(date +%s)
    mv "$d" "${d}.extensions.bak.$ts"
  fi
done

echo "== Create defensive workspace settings to reduce load =="
mkdir -p .vscode
cat > .vscode/settings.json <<'JSON'
{
  "files.watcherExclude": {
    "**/.git/**": true,
    "**/node_modules/**": true,
    "**/bin/**": true,
    "**/obj/**": true,
    "**/.cache/**": true
  },
  "search.exclude": {
    "**/.git/**": true,
    "**/node_modules/**": true,
    "**/bin/**": true,
    "**/obj/**": true,
    "**/.cache/**": true
  },
  "extensions.autoCheckUpdates": false,
  "extensions.autoUpdate": false
}
JSON

echo "== Resource check =="
free -h || true
df -h || true
ulimit -n || true

echo "== Done. Now reload the window in VS Code (Ctrl/Cmd+Shift+P → Developer: Reload Window) =="
