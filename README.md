# Claude Code Agent Toolkit

A comprehensive collection of **15 specialized AI agents** for [Claude Code](https://claude.ai/code) that cover every stage of software development — from product strategy to deployment.

> Think of it as hiring a full tech team, powered by Claude.

## Agents

| Agent | Role | Model | Focus |
|-------|------|-------|-------|
| **product-strategist** | Product decisions & prioritization | Opus | MVP scoping, feature prioritization, build-vs-buy analysis |
| **ui-ux-designer** | Design & user experience | Opus | Figma-to-code, UX flows, accessibility, design systems |
| **architect** | System architecture | Opus | Data models, API design, tech stack decisions, ADRs |
| **flutter-dev** | Flutter/Dart development | Opus | Widgets, Riverpod, GoRouter, Supabase integration |
| **backend-dev** | Backend development | Opus | Supabase, PostgreSQL, Edge Functions, RLS policies |
| **swift-dev** | iOS native development | Opus | SwiftUI, Swift concurrency, iOS platform features |
| **code-reviewer** | Code quality review | Sonnet | Read-only analysis, bug detection, quality scoring |
| **test-engineer** | Testing & QA | Sonnet | Unit, widget, integration tests, coverage analysis |
| **security-auditor** | Application security | Opus | OWASP Top 10, auth review, RLS audit, vulnerability scan |
| **devops-engineer** | CI/CD & deployment | Sonnet | GitHub Actions, app store deployment, monitoring |
| **performance-optimizer** | Performance tuning | Sonnet | Query optimization, render performance, bundle size |
| **debugger** | Bug investigation | Opus | Root cause analysis, systematic debugging, error tracing |
| **marketing-advisor** | App marketing & growth | Sonnet | ASO, user acquisition, push strategy, retention |
| **project-manager** | Project planning | Sonnet | Sprint planning, user stories, task breakdown, estimation |
| **database-expert** | Database specialist | Opus | Schema design, PostGIS, query optimization, migrations |

## Installation

### Quick Install

```bash
git clone https://github.com/YOUR_USERNAME/claude-agents.git
cd claude-agents
chmod +x install.sh
./install.sh
```

### Manual Install

Copy agent files to your Claude Code agents directory:

```bash
cp agents/*.md ~/.claude/agents/
```

### Symlink Install (auto-updates with git pull)

```bash
for f in agents/*.md; do
  ln -sf "$(pwd)/$f" ~/.claude/agents/$(basename "$f")
done
```

## Usage

Once installed, agents are automatically available in any Claude Code conversation.

### Automatic Delegation

Just describe what you need — Claude picks the right agent:

```
> "Review this code for security issues"
→ security-auditor activates

> "Design the database schema for a social feed"
→ database-expert activates

> "Break this feature into sprint tasks"
→ project-manager activates
```

### Explicit Invocation

Request a specific agent by name:

```
> "Use the code-reviewer to analyze the auth module"
> "Have the architect design the API for notifications"
> "Ask the marketing-advisor about ASO strategy"
```

### Parallel Execution

Run multiple agents simultaneously:

```
> "Review this PR with code-reviewer and security-auditor at the same time"
> "Have flutter-dev build the screen while test-engineer writes tests"
```

### Background Agents

Start an agent in the background and keep working:

```
> "Run code-reviewer in the background on the whole src/ directory"
> (continue working while it runs...)
> (get notified when done)
```

Or press **Ctrl+B** while an agent is running to send it to the background.

## Customization

Each agent is a simple Markdown file with YAML frontmatter. Customize freely:

```markdown
---
name: my-agent
description: When to use this agent (be specific — Claude reads this)
tools: Read, Edit, Write, Grep, Glob, Bash
model: opus
---

Your system prompt here. Tell the agent:
- What role it plays
- How to approach tasks
- What standards to follow
- How to format output
```

### Key Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier (lowercase, hyphens) |
| `description` | Yes | When Claude should use this agent |
| `tools` | No | Allowed tools (inherits all if omitted) |
| `model` | No | `opus`, `sonnet`, `haiku`, or `inherit` |
| `maxTurns` | No | Max agentic turns before stopping |
| `memory` | No | Persistent memory: `user`, `project`, or `local` |

## Uninstall

```bash
./uninstall.sh
```

Or manually:

```bash
rm ~/.claude/agents/{product-strategist,ui-ux-designer,architect,flutter-dev,backend-dev,swift-dev,code-reviewer,test-engineer,security-auditor,devops-engineer,performance-optimizer,debugger,marketing-advisor,project-manager,database-expert}.md
```

## Contributing

1. Fork this repo
2. Create or modify an agent in `agents/`
3. Test it in Claude Code
4. Submit a PR with a description of what the agent does

## License

MIT — use freely, modify freely, share freely.
