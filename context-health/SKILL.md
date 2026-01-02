---
name: context-health
description: Use proactively to monitor context window health and protect against overflow. Auto-triggers when sessions become long, when many files are loaded, or when approaching context limits. Provides strategies for context pruning, summarization, and session forking.
---

# Context Health Monitor

**Purpose**: Actively monitor and protect context window efficiency

## Auto-Trigger Conditions

This skill activates when:
- Session exceeds 50 tool calls
- Multiple large files read (>500 lines each)
- User mentions "context", "memory", "losing track"
- Approaching compact threshold

## Health Check Protocol

### Quick Check (Run Frequently)
```
1. Count tool calls this session
2. Estimate context usage (tool calls × ~2k tokens avg)
3. Check for repeated file reads (inefficiency signal)
4. Verify reference files being used
```

### Deep Check (Run Before Major Work)
```
1. Review what's loaded in context
2. Identify stale/irrelevant context
3. Recommend context clearing if needed
4. Suggest reference file strategy
```

## Context Efficiency Signals

### 🟢 Healthy
- Using reference files over re-reading
- Single task focus
- Incremental commits
- <30 tool calls

### 🟡 Warning
- 30-50 tool calls
- Multiple unrelated topics
- Re-reading same files
- No recent commits

### 🔴 Critical
- >50 tool calls
- Context feels "fuzzy"
- Repeated mistakes
- Should fork/clear

## Recovery Actions

### Level 1: Optimize
- Commit current work
- Clear completed todos
- Reference files instead of re-read

### Level 2: Fork
- Save state to reference file
- Suggest `/compact` or new session
- Provide handoff summary

### Level 3: Emergency Save
- Immediate git commit
- State dump to `.claude/memory/meztal/emergency-state.md`
- Clear instructions for resumption

## Context Loading Strategy

### By Task Type

| Task | Load | Skip |
|------|------|------|
| Content creation | compliance.md, brand-voice.md | wix rules |
| Wix development | wix-development.md, wix-cms-direct | content rules |
| Bug fix | error-handling.md, explore-first | content/wix |
| Planning | plan-mode.md, taskmaster | implementation rules |

### Progressive Loading
```
1. Task identified
2. Load ONLY relevant rules (1-2 files)
3. Load skill if needed
4. Reference other files dynamically
5. Never preload everything
```

## Memory Graph Usage

### Store in Memory Graph
- Project facts (Site ID, paths, constraints)
- Cross-session learnings
- Key decisions
- Error patterns and fixes

### Keep in Reference Files
- Detailed workflows
- Code examples
- Long documentation
- Templates

## Metrics to Track

```json
{
  "session_tool_calls": 0,
  "files_read": [],
  "files_read_twice": [],
  "commits_made": 0,
  "context_clears": 0,
  "reference_file_usage": 0
}
```

## Integration

**Hooks**:
- PreCompact: Save state automatically
- Stop: Report context health

**Called By**:
- context-manager skill
- Long sessions (auto-trigger)

**Calls**:
- memory MCP for persistence
- fork-terminal for session split
