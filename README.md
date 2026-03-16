# Claude Dev Squad

> Stop talking to one generic AI. Start delegating to a team of 15 specialists.

Claude Dev Squad turns [Claude Code](https://docs.anthropic.com/en/docs/claude-code) from a single assistant into **a full software development team** — product strategist, architect, developers, reviewers, security auditor, DevOps engineer, and more. Each agent thinks differently, uses different tools, and produces different outputs.

## The Problem

Without specialized agents, Claude Code operates in "one mode fits all":

- Architecture decisions and bug fixes get the same thinking depth
- Security review is an afterthought, not a dedicated pass
- Code review happens in the same context that wrote the code
- Product decisions are mixed with implementation details
- Testing strategy is improvised, not systematic
- Performance analysis competes with feature development for attention
- Marketing and growth are completely outside the conversation

**The result:** mediocre output across the board, because no single mode of thinking is great at everything.

## The Solution

Claude Dev Squad gives Claude Code **15 distinct cognitive modes**, each with its own expertise, methodology, and tool permissions:

### Strategy & Planning
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `product-strategist` | Feature decisions, MVP scoping, prioritization | CEO who codes |
| `project-manager` | Sprint planning, task breakdown, estimation | Scrum master |

### Design
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `ui-ux-designer` | Design review, UX flows, accessibility, Figma | Senior designer |

### Architecture
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `architect` | System design, API contracts, tech decisions | Principal engineer |
| `database-expert` | Schema design, query optimization, PostGIS, RLS | Senior DBA |

### Development
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `flutter-dev` | Flutter/Dart, Riverpod, GoRouter, widgets | Senior Flutter dev |
| `backend-dev` | Supabase, Edge Functions, PostgreSQL, Node.js | Backend lead |
| `swift-dev` | SwiftUI, Swift concurrency, iOS platform | Senior iOS dev |

### Quality & Security
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `code-reviewer` | Code quality, patterns, bug detection | Paranoid staff engineer |
| `test-engineer` | Unit/widget/integration tests, coverage | QA lead |
| `debugger` | Root cause analysis, systematic debugging | Detective |
| `security-auditor` | OWASP Top 10, auth review, vulnerability scan | Ethical hacker |

### Operations & Growth
| Agent | Role | Thinks Like... |
|-------|------|---------------|
| `devops-engineer` | CI/CD, deployment, monitoring, app stores | Release engineer |
| `performance-optimizer` | App speed, DB queries, bundle size | Performance nerd |
| `marketing-advisor` | ASO, user acquisition, push strategy | Growth hacker |

---

## How It Works

### Automatic Delegation

You don't need to remember agent names. Just describe what you need — Claude reads each agent's description and picks the right specialist:

```
You: "Is this feature worth building? We have limited resources."
     → product-strategist activates (scores with ICE framework, recommends go/no-go)

You: "Design the database schema for a campaign system with geolocation"
     → database-expert activates (PostGIS setup, RLS policies, indexes)

You: "Review this PR for security issues before we merge"
     → security-auditor activates (OWASP checklist, auth review, vulnerability report)
```

### Explicit Invocation

Request a specific agent when you want a particular perspective:

```
You: "Use the architect to design the notification system"
You: "Have the code-reviewer analyze the auth module"
You: "Ask the marketing-advisor about our ASO strategy"
```

### Parallel Execution

Run multiple agents simultaneously on different aspects of the same task:

```
You: "Review this PR — code-reviewer for quality, security-auditor for vulnerabilities"
     → Both run in parallel, return separate reports

You: "flutter-dev build the screen, test-engineer write tests at the same time"
     → Code and tests written concurrently
```

### Workflow Chains

Agents are designed to work in sequence. Each agent's output feeds naturally into the next:

```
product-strategist  →  architect  →  flutter-dev  →  code-reviewer  →  test-engineer  →  security-auditor  →  devops-engineer
    "what"             "how"         "build"          "quality"         "verify"           "secure"              "ship"
```

**Example — Full feature lifecycle:**

```
You: "I want to add a favorites feature to the app"

Step 1 — product-strategist scopes it:
  → ICE score: Impact 8, Confidence 9, Ease 7
  → MVP: heart button + favorites list, no folders
  → Recommendation: Build it, high retention signal

Step 2 — architect designs it:
  → ADR: favorites table with user_id + campaign_id
  → RLS policy: users see only their own favorites
  → API: toggle endpoint via Edge Function

Step 3 — database-expert implements the schema:
  → Migration SQL with indexes
  → RLS policies tested

Step 4 — flutter-dev builds the UI:
  → Heart button widget with animation
  → Favorites screen with Riverpod provider
  → Optimistic UI updates

Step 5 — code-reviewer checks quality:
  → Score: 8/10
  → Warning: missing error state in favorites list
  → Suggestion: add haptic feedback on favorite

Step 6 — test-engineer writes tests:
  → Unit: toggle provider logic
  → Widget: heart button states
  → Integration: full favorite flow

Step 7 — security-auditor verifies:
  → RLS policies verified
  → No data leakage between users
  → Auth token properly checked

Step 8 — devops-engineer ships it:
  → CI passes, PR created
  → Staged rollout recommended
```

You can run the whole chain, or jump to any step directly.

### Background Agents

Start an agent in the background and keep working:

```
You: "Run code-reviewer in the background on the whole src/ directory"
     → (keeps running while you continue working)
     → (notification when done)
```

Press **Ctrl+B** while an agent is running to send it to background.

---

## Installation

### Quick Install (30 seconds)

```bash
git clone https://github.com/enestalhaucar/claude-dev-squad.git
cd claude-dev-squad
./install.sh
```

That's it. No build step, no dependencies, no package manager. Start a new Claude Code conversation and your agents are ready.

### Manual Install

```bash
cp agents/*.md ~/.claude/agents/
```

### Symlink Install (auto-updates with git pull)

```bash
git clone https://github.com/enestalhaucar/claude-dev-squad.git ~/claude-dev-squad
cd ~/claude-dev-squad
for f in agents/*.md; do
  ln -sf "$(pwd)/$f" ~/.claude/agents/$(basename "$f")
done
```

Now `git pull` automatically updates all agents.

### Verify Installation

```bash
ls ~/.claude/agents/
# Should show 15 .md files
```

---

## Agent Details

### product-strategist

**Model:** Opus | **Tools:** Read, Grep, Glob, Bash, WebSearch, WebFetch

The product strategist helps you decide **what to build and why**. Uses the ICE/RICE framework for feature prioritization, scopes MVPs, and runs build-vs-buy analysis.

```
You: "Should we add a messaging feature between businesses and users?"

product-strategist:
  ICE Score: Impact 6 | Confidence 4 | Ease 2 → Score: 48/1000
  Decision: Don't build it now.
  Reasoning: High complexity, unclear user demand, diverts from core value.
  Alternative: Add a "call business" button (Impact 7, Ease 9 → Score: 567)
  Next Steps: Survey 50 users about communication preferences first.
```

---

### architect

**Model:** Opus | **Tools:** Read, Grep, Glob, Bash, WebSearch, WebFetch

Designs system architecture and makes technology decisions. Outputs Architecture Decision Records (ADRs) for every major choice.

```
You: "Design the real-time campaign notification system"

architect:
  ## ADR-001: Campaign Notifications via Supabase Realtime + FCM

  Context: Users need instant alerts when new campaigns appear nearby.

  Decision: Supabase Realtime for in-app, FCM for background push.

  Data Flow:
  business creates campaign → DB trigger → Edge Function →
    ├── Supabase Realtime → active app users (instant)
    └── FCM → background users (push notification)

  Alternatives Considered:
  - Polling (rejected: battery drain, delayed)
  - WebSocket server (rejected: infra overhead)

  Consequences: Depends on Supabase Realtime stability.
```

---

### flutter-dev

**Model:** Opus | **Tools:** Read, Edit, Write, Grep, Glob, Bash, LSP

Your primary mobile development agent. Writes production-ready Flutter code with Riverpod state management, GoRouter navigation, and Supabase integration.

```
You: "Build the campaign detail screen based on the Figma design"

flutter-dev:
  → Reads existing code patterns and theme
  → Creates CampaignDetailScreen with proper MVVM structure
  → Implements AsyncNotifierProvider for campaign data
  → Handles loading/error/empty states
  → Adds hero animation from list to detail
  → Uses theme tokens (no hardcoded colors)
```

---

### code-reviewer

**Model:** Sonnet | **Tools:** Read, Grep, Glob, Bash (read-only — cannot edit)

Reviews code for quality, correctness, and maintainability. Produces a scored report with prioritized findings. Intentionally has no Edit/Write access — separation of concerns.

```
You: "Review the auth module"

code-reviewer:
  Overall Score: 7/10 — Good with issues

  [CRITICAL] lib/auth/provider.dart:47
    Token stored in SharedPreferences (insecure on Android)
    → Use flutter_secure_storage instead

  [WARNING] lib/auth/login_screen.dart:82
    No rate limiting on login attempts
    → Add exponential backoff after 3 failures

  [PRAISE] lib/auth/auth_state.dart:15
    Clean AsyncNotifier pattern, good error handling

  Verdict: Fix critical issue before merge, warning can be follow-up.
```

---

### security-auditor

**Model:** Opus | **Tools:** Read, Grep, Glob, Bash, WebSearch (read-only + research)

Audits code for security vulnerabilities against OWASP Mobile Top 10. Thinks like an attacker, advises like a defender.

```
You: "Audit the Supabase RLS policies before launch"

security-auditor:
  [CRITICAL] campaigns table — pol_campaigns_update has no business_id check
    Impact: Any authenticated user can update any campaign
    Fix: ADD CHECK (business_id = auth.uid())

  [HIGH] user_profiles table — email column exposed via SELECT policy
    Impact: User emails harvestable via API
    Fix: Exclude email from public SELECT policy

  [MEDIUM] storage bucket "avatars" — no file type validation
    Impact: Malicious file upload possible
    Fix: Add MIME type check in upload policy

  Risk Score: HIGH — 1 critical, 1 high finding. Do not deploy.
```

---

### debugger

**Model:** Opus | **Tools:** Read, Edit, Write, Grep, Glob, Bash

Systematic bug investigator. Never guesses — reproduces, isolates, hypothesizes, proves, fixes.

```
You: "The app crashes when opening a campaign with no images"

debugger:
  1. Reproduced: CampaignDetailScreen crashes on campaigns where images = []
  2. Stack trace points to: image_carousel.dart:23 — images[0] called on empty list
  3. Root cause: ImageCarousel assumes at least 1 image, no empty check
  4. Fix: Added empty state with placeholder image
  5. Regression test: widget test with empty images list
  6. Similar pattern found in: business_gallery.dart:45 — fixed too
```

---

### database-expert

**Model:** Opus | **Tools:** Read, Edit, Write, Grep, Glob, Bash, WebSearch

PostgreSQL and Supabase specialist. Designs schemas, writes optimized queries, sets up PostGIS for geolocation, and crafts bulletproof RLS policies.

```
You: "Set up geospatial search for campaigns within 5km"

database-expert:
  1. Extension: CREATE EXTENSION IF NOT EXISTS postgis;
  2. Column: ALTER TABLE businesses ADD COLUMN location GEOGRAPHY(POINT, 4326);
  3. Index: CREATE INDEX idx_businesses_location ON businesses USING GIST(location);
  4. Query: ST_DWithin(location, ST_MakePoint(lng, lat)::geography, 5000)
  5. RLS: Policy allows public SELECT with distance filter
  6. Edge Function: /nearby-campaigns endpoint with pagination
  Performance: ~2ms for 10K businesses within 5km radius
```

---

### test-engineer

**Model:** Sonnet | **Tools:** Read, Edit, Write, Grep, Glob, Bash

Writes comprehensive tests following the testing pyramid: 70% unit, 20% widget, 10% integration.

---

### devops-engineer

**Model:** Sonnet | **Tools:** Read, Edit, Write, Grep, Glob, Bash, WebSearch

Sets up CI/CD pipelines, automates app store deployment, configures monitoring and alerting.

---

### performance-optimizer

**Model:** Sonnet | **Tools:** Read, Edit, Write, Grep, Glob, Bash

Finds and fixes performance bottlenecks. Measures before optimizing — never guesses.

---

### marketing-advisor

**Model:** Sonnet | **Tools:** Read, Grep, Glob, Bash, WebSearch, WebFetch

App Store Optimization, user acquisition strategies, push notification campaigns, and growth tactics.

---

### project-manager

**Model:** Sonnet | **Tools:** Read, Grep, Glob, Bash, WebSearch

Breaks features into user stories, plans sprints, estimates effort, and tracks dependencies.

---

### ui-ux-designer

**Model:** Opus | **Tools:** Read, Grep, Glob, Bash, WebSearch, WebFetch

Design review, Figma-to-code guidance, accessibility checks, and UX flow analysis.

---

### backend-dev

**Model:** Opus | **Tools:** Read, Edit, Write, Grep, Glob, Bash, WebSearch

Supabase Edge Functions, RLS policies, auth flows, storage management, and API design.

---

### swift-dev

**Model:** Opus | **Tools:** Read, Edit, Write, Grep, Glob, Bash, LSP

Native iOS development with SwiftUI, Swift concurrency, and platform-specific features.

---

## Customization

Each agent is a plain Markdown file. Customize freely:

```markdown
---
name: my-agent
description: When Claude should use this agent (be specific!)
tools: Read, Edit, Write, Grep, Glob, Bash
model: opus          # opus | sonnet | haiku | inherit
maxTurns: 20         # limit agent iterations
memory: project      # persistent memory: user | project | local
---

System prompt goes here. Define:
- Role and mindset
- Step-by-step methodology
- Output format
- Guiding principles
```

### Model Selection Guide

| Model | Cost | Speed | Use For |
|-------|------|-------|---------|
| `opus` | $$$ | Slower | Architecture, security, debugging — decisions that matter |
| `sonnet` | $ | Faster | Reviews, tests, routine tasks — output you can verify quickly |
| `haiku` | ¢ | Fastest | Simple lookups, formatting, boilerplate |

### Tool Permissions

Follow the principle of least privilege:

```
Read-only agents (reviewers, auditors):  Read, Grep, Glob, Bash
Write agents (developers, fixers):       Read, Edit, Write, Grep, Glob, Bash
Research agents (strategists, marketers): Read, Grep, Glob, Bash, WebSearch, WebFetch
```

---

## How It Compares

| Feature | Claude Dev Squad | Generic Claude Code |
|---------|-----------------|-------------------|
| Cognitive modes | 15 specialized | 1 generic |
| Auto-delegation | Yes (by description) | N/A |
| Parallel agents | Yes | N/A |
| Tool restrictions | Per-agent | All tools always |
| Output format | Standardized per role | Varies |
| Security review | Dedicated OWASP audit | Ad-hoc |
| Workflow chains | Plan→Build→Review→Ship | Manual |
| Install time | 30 seconds | N/A |
| Dependencies | None | N/A |

---

## Uninstall

```bash
./uninstall.sh
```

Or manually:

```bash
rm ~/.claude/agents/{product-strategist,ui-ux-designer,architect,flutter-dev,backend-dev,swift-dev,code-reviewer,test-engineer,security-auditor,devops-engineer,performance-optimizer,debugger,marketing-advisor,project-manager,database-expert}.md
```

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on adding or improving agents.

## Architecture

See [ARCHITECTURE.md](ARCHITECTURE.md) for design decisions and trade-offs.

## License

MIT — use freely, modify freely, share freely.
