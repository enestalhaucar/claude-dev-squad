#!/bin/bash

# Claude Code Agent Toolkit — Installer
# Installs all agents to ~/.claude/agents/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SOURCE="$SCRIPT_DIR/agents"
AGENTS_TARGET="$HOME/.claude/agents"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Claude Code Agent Toolkit — Installer      ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════╝${NC}"
echo ""

# Check if Claude Code directory exists
if [ ! -d "$HOME/.claude" ]; then
    echo -e "${YELLOW}~/.claude directory not found. Creating it...${NC}"
    mkdir -p "$HOME/.claude"
fi

# Create agents directory
mkdir -p "$AGENTS_TARGET"

# Count agents
AGENT_COUNT=$(ls -1 "$AGENTS_SOURCE"/*.md 2>/dev/null | wc -l | tr -d ' ')

if [ "$AGENT_COUNT" -eq 0 ]; then
    echo "No agent files found in $AGENTS_SOURCE"
    exit 1
fi

echo -e "Found ${GREEN}$AGENT_COUNT${NC} agents to install."
echo ""

# Install each agent
INSTALLED=0
SKIPPED=0
UPDATED=0

for agent_file in "$AGENTS_SOURCE"/*.md; do
    filename=$(basename "$agent_file")
    target_file="$AGENTS_TARGET/$filename"

    if [ -f "$target_file" ]; then
        # Check if files are different
        if ! diff -q "$agent_file" "$target_file" > /dev/null 2>&1; then
            cp "$agent_file" "$target_file"
            echo -e "  ${YELLOW}↻${NC} Updated: $filename"
            ((UPDATED++))
        else
            echo -e "  ${BLUE}→${NC} Skipped (unchanged): $filename"
            ((SKIPPED++))
        fi
    else
        cp "$agent_file" "$target_file"
        echo -e "  ${GREEN}✓${NC} Installed: $filename"
        ((INSTALLED++))
    fi
done

echo ""
echo -e "${GREEN}Done!${NC}"
echo -e "  Installed: ${GREEN}$INSTALLED${NC}"
echo -e "  Updated:   ${YELLOW}$UPDATED${NC}"
echo -e "  Unchanged: ${BLUE}$SKIPPED${NC}"
echo ""
echo -e "Agents are now available in Claude Code. Start a new conversation to use them."
echo -e "Try: ${GREEN}\"Review this code with the code-reviewer agent\"${NC}"
echo ""
