---
name: learning-loop
description: Captures patterns from each session and compounds knowledge over time. Auto-triggers on session end to extract learnings. Use "what did we learn" to manually trigger review.
---

# Cross-Session Learning Loop

**Purpose**: Compound knowledge across sessions automatically

## Learning Capture

### On Session End (Automatic)
```
1. Review session actions
2. Identify new patterns
3. Extract reusable insights
4. Store to memory graph
5. Update reference files if significant
```

### What to Capture

| Category | Examples | Store In |
|----------|----------|----------|
| **Error fixes** | "JSON parse error → heal-json.py" | Memory graph |
| **Workflow improvements** | "Pre-check before content" | IDEAS_LOG.md |
| **Tool discoveries** | "Use Explore agent for X" | TOOLKIT_MANIFEST.md |
| **Compliance patterns** | "Always check both cities" | Memory graph |

## Memory Graph Updates

### New Pattern Discovered
```
mcp__memory__add_observations({
  entityName: "Session_Patterns",
  contents: ["New pattern: [description]"]
})
```

### Error Pattern
```
mcp__memory__create_entities([{
  name: "Error_Pattern_[name]",
  entityType: "BugFix",
  observations: ["Symptom: ...", "Fix: ...", "Prevention: ..."]
}])
```

## Reference File Updates

### When to Update
- New tool discovered → TOOLKIT_MANIFEST.md
- Workflow improvement → SOP.md
- Significant insight → IDEAS_LOG.md
- Compliance issue → compliance.md

### Update Protocol
```
1. Identify significance (high/medium/low)
2. High: Update reference file + commit
3. Medium: Add to IDEAS_LOG.md
4. Low: Store in memory graph only
```

## Knowledge Compounding

### Weekly Review (Manual)
```
1. Review memory graph for patterns
2. Identify frequently-used observations
3. Promote to reference files if stable
4. Clean up outdated observations
```

### Monthly Optimization
```
1. Review all reference files
2. Remove stale content
3. Consolidate related patterns
4. Update CLAUDE.md if needed
```

## Integration

**Hooks**:
- SessionEnd: Auto-trigger learning capture
- /compound: Manual trigger

**Stores To**:
- memory MCP (primary)
- IDEAS_LOG.md (insights)
- Reference files (stable patterns)
