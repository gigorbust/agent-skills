---
name: knowledge-capture
description: Use when identifying patterns worth preserving, after solving complex problems, or when repeating similar work. Automates the capture of institutional knowledge into skills, Knowledge Items, and reusable patterns.
---

# Knowledge Capture

## Overview

Systematically capture institutional knowledge to prevent re-learning. If you solved it once cleverly, it becomes reusable.

## Capture Triggers

### Automatic Capture Signals
- "I've done this before" → Should be a skill
- "Where did I see that?" → Should be in a KI
- "Let me look up how..." → Should be in cookbook
- "This is the third time..." → MUST be captured now

### Post-Task Questions
After completing any significant task:
1. Is there a reusable pattern here?
2. Would this be useful in other contexts?
3. What did I wish I knew before starting?

## Capture Destinations

| Pattern Type | Destination | When to Use |
|:-------------|:------------|:------------|
| Repeatable workflow | Skill | Multi-step process |
| Quick command | Cookbook | One-liner / recipe |
| Domain knowledge | Knowledge Item | Facts, context |
| Project-specific | Memory file | Local context |
| Reusable template | Assets folder | Starting points |

## Capture Workflow

### 1. Identify
After task completion:
```markdown
## Capture Candidate
- What worked well?
- What was non-obvious?
- What would help next time?
```

### 2. Classify
```
Is it a PROCESS? → Skill
Is it a COMMAND? → Cookbook
Is it KNOWLEDGE? → KI
Is it LOCAL? → Memory
```

### 3. Create
Use appropriate skill:
- `skill-creator` for new skills
- Add to `cli-cookbook` for commands
- Create KI in knowledge directory
- Add to project memory

### 4. Verify
- Test the captured knowledge
- Ensure it triggers correctly
- Validate it's findable

## Integration Points

### With Session End
The `session-end` hook prompts:
- Any patterns to capture?
- Should this become a skill?

### With Content Production
Successful content patterns → templates in factory skill

### With Debugging
Root cause fixes → debugging cookbook

## Anti-Patterns

**Don't capture:**
- One-off solutions
- Context-specific hacks
- Overly narrow patterns

**Do capture:**
- Generalizable patterns
- Non-obvious solutions
- Time-saving shortcuts

## Quick Capture Template

```markdown
## Pattern: [Name]

### Problem
[What were you solving?]

### Solution
[How did you solve it?]

### Key Insight
[What's the non-obvious part?]

### Reusability
[How/when to use again]
```
