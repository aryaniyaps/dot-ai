#!/bin/bash
set -euo pipefail

REPO_DIR="$HOME/dot-ai"
CLAUDE_DST="$HOME/.claude"
OPENCODE_DST="$HOME/.opencode"

# Ensure repo is fresh
cd "$REPO_DIR"
git pull || true   # safe if no remote yet

# Restore Claude config
if [[ -d "$REPO_DIR/.claude" ]]; then
    mkdir -p "$CLAUDE_DST"
    rsync -av --delete "$REPO_DIR/.claude/" "$CLAUDE_DST/"
    echo "Restored Claude Code config."
fi

# Restore OpenCode config
if [[ -d "$REPO_DIR/.opencode" ]]; then
    mkdir -p "$OPENCODE_DST"
    rsync -av --delete "$REPO_DIR/.opencode/" "$OPENCODE_DST/"
    echo "Restored OpenCode config."
fi
