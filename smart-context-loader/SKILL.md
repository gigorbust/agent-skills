---
name: smart-context-loader
description: Automatically loads ONLY relevant context based on task type. Triggers at session start and when task type changes. Prevents context bloat by selective loading. Use when starting work or switching domains.
---

# Smart Context Loader

**Purpose**: Load minimum necessary context for maximum efficiency

## Task Detection & Loading

### Content Tasks
**Triggers**: "write", "create", "blog", "pillar", "spoke", "content", "SEO"

**Auto-Load**:
```
1. Memory: Compliance_Rules entity
2. Rule: .claude/rules/compliance.md
3. Skill: meztal-content (if complex)
```

**Skip**: wix-development.md, analytics rules

### Wix Tasks
**Triggers**: "wix", "velo", "cms", "collection", "dynamic page", "upload"

**Auto-Load**:
```
1. Memory: Wix_Development entity
2. Rule: .claude/rules/wix-development.md
3. Skill: wix-cms-direct or wix-velo-generator
```

**Skip**: content rules, compliance (unless content upload)

### Planning Tasks
**Triggers**: "plan", "design", "architecture", "strategy", "implement"

**Auto-Load**:
```
1. Memory: Session_Patterns entity
2. Rule: .claude/rules/plan-mode.md
3. Reference: current task from TaskMaster
```

**Skip**: implementation-specific rules

### Debug/Fix Tasks
**Triggers**: "fix", "debug", "error", "broken", "issue"

**Auto-Load**:
```
1. Rule: .claude/rules/error-handling.md
2. Skill: systematic-debugging
3. Recent: git log, error context
```

**Skip**: content rules, planning rules

### Research Tasks
**Triggers**: "research", "find", "search", "explore", "understand"

**Auto-Load**:
```
1. Skill: explore-first pattern
2. MCP: exa, brave-search
3. Tool: Task(Explore) agent
```

**Skip**: All implementation rules

## Loading Protocol

```
Task Received
    ↓
Detect task type (keyword match)
    ↓
Query memory graph for relevant entities
    ↓
Load ONLY matched rules (1-2 max)
    ↓
Reference skills (don't preload)
    ↓
Begin work with minimal context
```

## Anti-Patterns

### ❌ Preload Everything
```
# BAD - loads all context upfront
Read CLAUDE.md
Read all rules
Read all skills
Then start work
```

### ✅ Load On Demand
```
# GOOD - loads only what's needed
Detect: "write blog post"
Load: compliance.md (one rule)
Reference: meztal-content skill
Start work immediately
```

## Memory Graph Integration

### Query Before Loading
```
mcp__memory__search_nodes("task type keywords")
→ Returns relevant entities
→ Extract observations
→ Use as context (not full files)
```

### Example: Content Task
```
Query: "compliance content"
Returns: Compliance_Rules entity
Observations:
- "approximately 40% cost savings"
- Both cities required
- No salary figures
→ Use observations directly (not full compliance.md)
```

## Context Budget

| Task Type | Max Files | Max Tokens |
|-----------|-----------|------------|
| Simple | 1 rule | ~5k |
| Medium | 2 rules + 1 skill | ~15k |
| Complex | 3 rules + skill + agent | ~30k |

## Session Start Protocol

```bash
# 1. Load from memory graph (fast, small)
mcp__memory__open_nodes(["Session_Patterns", "File_Locations"])

# 2. Get task context
task-master next

# 3. Detect task type from TaskMaster output

# 4. Load ONLY relevant context
```

## Integration

**Called By**:
- SessionStart hook
- context-orchestrator skill
- Manual: "load context for [task type]"

**Calls**:
- memory MCP (query entities)
- Rules (selective read)
- Skills (reference only)
