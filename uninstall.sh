#!/bin/bash

# Claude Code Agent Toolkit — Uninstaller
# Removes installed agents from ~/.claude/agents/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SOURCE="$SCRIPT_DIR/agents"
AGENTS_TARGET="$HOME/.claude/agents"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo ""
echo "Claude Code Agent Toolkit — Uninstaller"
echo "========================================"
echo ""

REMOVED=0

for agent_file in "$AGENTS_SOURCE"/*.md; do
    filename=$(basename "$agent_file")
    target_file="$AGENTS_TARGET/$filename"

    if [ -f "$target_file" ]; then
        rm "$target_file"
        echo -e "  ${RED}✕${NC} Removed: $filename"
        ((REMOVED++))
    fi
done

echo ""
echo -e "${GREEN}Done!${NC} Removed $REMOVED agents."
echo ""
