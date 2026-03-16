# Architecture

Design decisions behind Claude Dev Squad and the reasoning for each.

## Why Agents, Not Skills?

Claude Code has two extension mechanisms: **skills** (slash commands) and **agents** (autonomous subprocesses). We chose agents because:

| | Skills | Agents |
|--|--------|--------|
| Invocation | Manual (`/command`) | Automatic (Claude decides) |
| Isolation | Shares main context | Own context window |
| Parallelism | One at a time | Multiple concurrent |
| Delegation | User must know the command | Claude matches task to agent |

**Decision:** Agents are the better fit for a "virtual team" model. You describe what you need, Claude assigns the right specialist. No memorizing slash commands.

## Agent Design Philosophy

### Cognitive Separation

The core insight: **different tasks require different thinking modes.**

A code reviewer should think like a paranoid skeptic. A product strategist should think like an optimistic visionary. A debugger should think like a detective. Mixing these modes in one conversation produces mediocre results.

Each agent is a **distinct cognitive mode** with its own:
- Mental model (how to think about the problem)
- Methodology (step-by-step process)
- Output format (what the result looks like)
- Tool permissions (what it can touch)

### Principle of Least Privilege

Agents get only the tools they need:

```
code-reviewer  → Read, Grep, Glob, Bash     (read-only: analyze, don't change)
flutter-dev    → Read, Edit, Write, Grep...  (full access: needs to write code)
security-auditor → Read, Grep, Glob, Bash, WebSearch  (read + research, no edit)
```

This prevents accidents (reviewer accidentally editing code) and keeps agents focused.

### Model Selection Strategy

Not every task needs the most expensive model:

```
opus   → Complex reasoning, architecture, security (worth the cost)
sonnet → Routine tasks, reviews, test writing (fast and cheap)
```

**Rule of thumb:** If the agent makes decisions that are hard to reverse (architecture, security), use `opus`. If it produces output that's easy to verify and iterate (tests, reviews), use `sonnet`.

## Workflow Chains

Agents are independent but designed to work in sequence:

```
product-strategist → architect → flutter-dev → code-reviewer → test-engineer → security-auditor → devops-engineer
     (what)          (how)       (build)        (quality)       (verify)        (secure)          (ship)
```

Each agent's output format is designed to be useful as input for the next agent in the chain. For example:
- `architect` produces ADRs and data models → `flutter-dev` consumes these
- `flutter-dev` produces code → `code-reviewer` analyzes it
- `code-reviewer` produces findings → `debugger` fixes critical issues

This isn't enforced — it's emergent. Claude naturally chains agents when the task requires it.

## Why Markdown?

Agents are defined as Markdown files with YAML frontmatter because:

1. **No build step** — copy the file, it works
2. **Version control friendly** — diffs are readable
3. **Human readable** — anyone can understand and modify
4. **No dependencies** — no runtime, no package manager
5. **Portable** — works on any OS with Claude Code

We intentionally avoid:
- Template systems (adds complexity, minimal benefit)
- Code generation (harder to customize)
- Binary formats (can't diff or review)

## Directory Structure

```
claude-dev-squad/
├── agents/          # One .md file per agent (the product)
├── .github/         # CI validation
├── install.sh       # Copy agents to ~/.claude/agents/
├── uninstall.sh     # Remove agents
├── README.md        # User-facing docs
├── ARCHITECTURE.md  # This file (design decisions)
├── CONTRIBUTING.md  # How to contribute
├── CHANGELOG.md     # Release history
├── VERSION          # Semantic version
└── LICENSE          # MIT
```

Flat and simple. No nested modules, no build artifacts, no dependencies.

## Why 15 Agents?

We cover the full software development lifecycle because **most projects need more than just coding help:**

```
Ideation    → product-strategist
Planning    → project-manager
Design      → ui-ux-designer
Architecture → architect, database-expert
Development → flutter-dev, backend-dev, swift-dev
Quality     → code-reviewer, test-engineer
Debugging   → debugger
Security    → security-auditor
Performance → performance-optimizer
Deployment  → devops-engineer
Growth      → marketing-advisor
```

Each agent is optional. Install all 15 or pick the ones you need.

## Trade-offs We Accept

1. **No inter-agent communication protocol** — Agents don't talk to each other directly. Claude mediates. This is simpler but means Claude must understand the full context.

2. **No persistent memory by default** — Agents start fresh each invocation. This prevents stale state but means repeated context building. Users can enable `memory:` in frontmatter if needed.

3. **No build system** — Agent prompts are hand-written, not generated. This means updates require manual editing of each file, but it keeps the system dead simple.

4. **No enforcement of workflows** — The plan → build → review → ship chain is suggested, not enforced. Users can invoke any agent at any time. Freedom over structure.

5. **Broad over deep** — 15 agents covering many areas vs. 5 agents going extremely deep. We optimize for coverage because most developers need breadth. Depth can be added per-agent over time.
