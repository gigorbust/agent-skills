---
name: predictive-loader
description: Predicts what context will be needed based on patterns and pre-loads it before user asks. Learns from session patterns to anticipate needs. Auto-triggers on session start and after each major task completion.
---

# Predictive Context Loader

**Purpose**: Anticipate context needs before user asks

## Prediction Patterns

### Pattern 1: Time-Based
```
Morning sessions → Usually start with task-master next
After content creation → Usually needs compliance check
After Wix work → Usually needs preview/test
End of day → Usually needs commit/push
```

### Pattern 2: Task Sequence
```
After research → Likely implementation
After planning → Likely execution
After bug fix → Likely verification
After feature → Likely testing
```

### Pattern 3: File Patterns
```
Editing .md in CLAUDE-AI-WORK → Preload compliance rules
Editing .js in src/ → Preload wix-development rules
Reading tasks.json → Preload taskmaster workflow
Creating new file → Preload explore-first pattern
```

## Pre-Loading Strategy

### On Session Start
```
1. Query memory: mcp__memory__open_nodes(["Session_Patterns"])
2. Check git status for pending work
3. Check TaskMaster for current task
4. Pre-load ONE relevant rule based on task type
```

### After Task Completion
```
1. Predict next likely task
2. Pre-fetch relevant context
3. Keep in reference (don't load full context)
```

## Learning Loop

### Track Patterns
```json
{
  "session_patterns": [
    {"trigger": "morning", "followed_by": "task-master next", "frequency": 0.9},
    {"trigger": "content_created", "followed_by": "compliance_check", "frequency": 0.95},
    {"trigger": "bug_fixed", "followed_by": "verification", "frequency": 0.85}
  ]
}
```

### Update Predictions
After each session:
1. Log what was actually needed
2. Compare to predictions
3. Adjust confidence scores
4. Improve next session

## Integration

**Calls**:
- memory MCP (patterns storage)
- TaskMaster (current task)
- Git (pending work)

**Called By**:
- SessionStart hook
- After task completion
