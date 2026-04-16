#!/bin/bash
set -euo pipefail

# Paths (adjust if your ~/.opencode location differs)
REPO_DIR="$HOME/dot-ai"
CLAUDE_SRC="$HOME/.claude"
OPENCODE_SRC="$HOME/.opencode"

# Ensure repo exists
if [[ ! -d "$REPO_DIR" ]]; then
    echo "Creating repo directory: $REPO_DIR"
    mkdir -p "$REPO_DIR"
fi

cd "$REPO_DIR"

# Check if it's a git repo; if not, init
if [[ ! -d "$REPO_DIR/.git" ]]; then
    git init
    git checkout -b main
    echo "# Agentic coding configs" >> README.md
    git add README.md
    git commit -m "chore: init repo" || true
fi

# Sync Claude config
if [[ -d "$CLAUDE_SRC" ]]; then
    mkdir -p "$REPO_DIR/claude"
    rsync -av --delete "$CLAUDE_SRC/" "$REPO_DIR/claude/"
    echo "Backed up Claude Code config."
fi

# Sync OpenCode config
if [[ -d "$OPENCODE_SRC" ]]; then
    mkdir -p "$REPO_DIR/opencode"
    rsync -av --delete "$OPENCODE_SRC/" "$REPO_DIR/opencode/"
    echo "Backed up OpenCode config."
fi

# Stage and commit changes
if ! git diff --quiet; then
    git add .
    git commit -m "backup: Claude + OpenCode configs" || true
    echo "Changes committed."
else
    echo "No changes to commit."
fi

# Optional: push to remote (uncomment and set origin)
# git remote add origin YOUR_REMOTE_URL  # first time
# git push -u origin main
