---
name: execution-tracer
description: Traces execution flow through agents, skills, and tools. Provides observability into what was called, why, and what it produced. Use "trace" or "what happened" to review execution path. Auto-captures on complex workflows.
---

# Intelligent Execution Tracer

**Purpose**: Full observability into agentic execution flow

## Trace Capture

### What Gets Traced
```
┌─────────────────────────────────────────────────────────────┐
│ TRACE: [timestamp] [session_id]                              │
├─────────────────────────────────────────────────────────────┤
│ REQUEST: User prompt                                         │
│                                                              │
│ ROUTING DECISION:                                            │
│   ├─ Detected: [keywords]                                    │
│   ├─ Route: [agent/skill/direct]                            │
│   └─ Reason: [why this route]                               │
│                                                              │
│ CONTEXT LOADED:                                              │
│   ├─ Memory entities: [list]                                │
│   ├─ Rules: [files]                                         │
│   └─ Skills: [names]                                        │
│                                                              │
│ EXECUTION PATH:                                              │
│   1. [Tool/Action] → [Result summary]                       │
│   2. [Tool/Action] → [Result summary]                       │
│   ...                                                        │
│                                                              │
│ OUTCOME:                                                     │
│   ├─ Success: [yes/no]                                      │
│   ├─ Files modified: [list]                                 │
│   ├─ Commits: [hashes]                                      │
│   └─ Duration: [time]                                       │
│                                                              │
│ LEARNINGS:                                                   │
│   ├─ What worked: [observations]                            │
│   └─ What could improve: [suggestions]                      │
└─────────────────────────────────────────────────────────────┘
```

## Trace Levels

### Level 1: Summary (Default)
```
[12:30:45] Content task → meztal-content skill → compliance check → PASS
```

### Level 2: Detailed
```
[12:30:45] REQUEST: "create blog about nearshore accounting"
[12:30:45] ROUTE: Content domain → meztal-content-orchestrator
[12:30:46] CONTEXT: Loaded compliance.md, brand-voice.md
[12:30:47] ACTION: Duplicate check → PASS (no match)
[12:31:02] ACTION: Content generation → 1,450 words
[12:31:05] ACTION: Compliance validation → PASS
[12:31:06] COMMIT: "Add nearshore accounting blog"
[12:31:06] OUTCOME: Success, 1 file created
```

### Level 3: Debug
```
Full tool call parameters, responses, timing, memory queries, etc.
```

## Trace Storage

### In-Session (Active Trace)
```javascript
// Store in session state
{
  "trace_id": "session_20251230_1230",
  "steps": [
    {"time": "12:30:45", "action": "route", "target": "content-orchestrator"},
    {"time": "12:30:46", "action": "load", "context": ["compliance.md"]},
    ...
  ],
  "metrics": {
    "total_time": "21s",
    "tool_calls": 8,
    "files_read": 3,
    "files_modified": 1
  }
}
```

### Cross-Session (Memory Graph)
```
mcp__memory__create_entities([{
  name: "Trace_[date]_[id]",
  entityType: "ExecutionTrace",
  observations: ["Summary of execution", "Key decisions", "Outcome"]
}])
```

## Trace Analysis

### Pattern Detection
```
Analyze traces to find:
- Common routing paths
- Frequently loaded context
- Tool call sequences
- Error patterns
- Performance bottlenecks
```

### Optimization Signals
```
IF same file read 3+ times in session → Add to predictive loader
IF routing decision changed → Log decision factor
IF task took >60s → Analyze for parallelization
IF error occurred → Capture fix pattern
```

## Usage

### View Current Trace
"trace" or "what happened" → Shows current session trace

### View Historical
"show trace [date/id]" → Query memory for past traces

### Analyze Patterns
"trace analysis" → Summarize patterns across traces

## Integration

**Hooks**:
- Every tool call → Append to trace
- SessionEnd → Store trace summary to memory

**Calls**:
- memory MCP (storage)
- All tools (observation)

**Output**:
- Session trace: In-memory
- Historical: Memory graph
- Analysis: On-demand
