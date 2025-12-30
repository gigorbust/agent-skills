---
name: context-manager
description: Use automatically to monitor context window health and protect against context overflow. Triggers when sessions become long, when many files are loaded, or when approaching context limits. Provides strategies for context pruning, summarization, and session forking.
---

# Context Manager Skill

## Overview

Protects context window integrity by monitoring usage and suggesting optimization strategies. Runs passively during long sessions.

## Context Health Indicators

### Warning Signs
- Session exceeds 50+ exchanges
- Multiple large files loaded (>500 lines each)
- Conversation summary mentions many distinct topics
- User mentions "we discussed earlier" frequently

### Critical Signs
- Responses becoming inconsistent with earlier context
- Forgetting recent decisions
- Repeating previously completed work

## Protection Strategies

### 1. Progressive Disclosure (Preventive)

Load only what's needed:

```markdown
# Instead of loading entire API docs
See [AUTH.md](references/AUTH.md) for authentication details.

# Claude reads AUTH.md only when auth is needed
```

### 2. Context Pruning (Active)

When context is heavy:
1. Summarize completed work in Knowledge Item
2. Create checkpoint document
3. Reference document instead of retaining details

### 3. Fork Terminal (Emergency)

When context is critical:
1. Use `fork-terminal` skill
2. Pass summarized context to new session
3. Continue with fresh context window

## Integration Points

### With Skills
- Monitor skill loading patterns
- Suggest skill alternatives with lighter context

### With Sub-agents
- Prefer sub-agents for scale operations
- Context isolation is a feature, not a bug

### With MCPs
- MCPs load on startup - consider impact
- Disconnect unused MCPs in long sessions

## Quick Actions

| Situation | Action |
|:----------|:-------|
| File already viewed | Reference by name, don't re-load |
| Large file needed | View specific line ranges only |
| Repeated pattern | Externalize to skill/script |
| Heavy session | Fork or summarize |

## Red Flags

**Never:**
- Load entire large files when partial suffices
- Keep all MCPs connected when only one needed
- Lose critical decisions to context amnesia

**Always:**
- Reference files by name after viewing
- Use line ranges for targeted viewing
- Summarize key decisions for persistence
