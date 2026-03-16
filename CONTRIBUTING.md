# Contributing to Claude Dev Squad

Thanks for your interest in contributing! This project thrives on community input.

## How to Contribute

### Adding a New Agent

1. Create a new `.md` file in `agents/`
2. Follow the frontmatter format:

```markdown
---
name: your-agent-name
description: When Claude should delegate to this agent (be specific and comprehensive)
tools: Read, Grep, Glob, Bash
model: opus
---

Your agent's system prompt here.
```

3. Include these sections in the prompt:
   - **Role definition** — who is this agent?
   - **When invoked** — what triggers this agent?
   - **Process/methodology** — step-by-step approach
   - **Output format** — how should results be structured?
   - **Principles** — guiding rules
   - **Examples** — real usage scenarios

4. Test the agent in Claude Code
5. Submit a PR

### Improving an Existing Agent

- Make the description more specific (better auto-delegation)
- Add edge cases to the methodology
- Improve output format consistency
- Add real-world examples
- Fix tool permissions (principle of least privilege)

### Guidelines

**Agent Design Principles:**
- Each agent should have ONE clear responsibility
- Read-only agents (reviewers, auditors) should NOT have Edit/Write tools
- Use `opus` for complex reasoning, `sonnet` for routine tasks
- Descriptions should be comprehensive — Claude reads them to decide delegation
- Include concrete examples, not just abstract instructions

**Code Style:**
- Frontmatter: YAML, lowercase keys
- Agent names: lowercase with hyphens (`my-agent-name`)
- Markdown: ATX headings (`##`), fenced code blocks
- Keep prompts focused — long ≠ better

**Testing Your Agent:**
1. Install locally: `cp agents/your-agent.md ~/.claude/agents/`
2. Start a new Claude Code conversation
3. Try both explicit invocation ("use the X agent") and implicit delegation
4. Verify the agent uses only its allowed tools
5. Check output format matches the spec

**PR Checklist:**
- [ ] Agent has name, description, tools, and model in frontmatter
- [ ] Description is specific enough for auto-delegation
- [ ] Tools follow principle of least privilege
- [ ] Prompt includes role, process, output format, and principles
- [ ] Tested in Claude Code
- [ ] README table updated (if new agent)

## Reporting Issues

- Agent gives wrong output → describe the input and expected vs actual output
- Agent uses wrong tools → list the tools it should/shouldn't use
- Auto-delegation fails → share the prompt that should have triggered the agent
- Conflicting agents → describe which agents compete for the same task

## Development Setup

```bash
# Clone the repo
git clone https://github.com/enestalhaucar/claude-dev-squad.git
cd claude-dev-squad

# Install agents locally
./install.sh

# Make changes to agents/
# Test in Claude Code

# Submit PR
```

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
