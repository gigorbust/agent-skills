---
name: observability-metrics
description: Comprehensive observability with zoom-in (single run) and zoom-out (aggregate) metrics. Logs agent decisions, tracks quality, implements sampling strategy. Auto-triggers on all agent workflows.
---

# Observability Metrics Skill

**Purpose**: Full visibility into agent behavior at micro and macro levels

## Metric Levels

### Zoom-In Metrics (Single Run)
```
For debugging individual executions:
- Full trace of every step
- Prompts sent and received
- Tool calls with parameters
- Decision reasoning
- Timing per operation
- Errors and retries
```

### Zoom-Out Metrics (Aggregate)
```
For understanding system behavior:
- Success rate over time
- Average latency by task type
- Hallucination rate
- Cost trends
- Most common failure patterns
- Agent utilization
```

## What to Log

### Agent Decision Logging
```json
{
  "timestamp": "ISO8601",
  "agent": "agent_name",
  "decision": {
    "action": "what was done",
    "reasoning": "why it was chosen",
    "alternatives_considered": ["other options"],
    "confidence": 0.85,
    "context_factors": ["what influenced decision"]
  }
}
```

### Example Decision Log
```json
{
  "timestamp": "2025-12-30T12:00:00Z",
  "agent": "intelligent-router",
  "decision": {
    "action": "route_to_content_orchestrator",
    "reasoning": "Request contains 'blog post' keyword and 'SEO' - matches content domain",
    "alternatives_considered": ["direct_to_writer", "research_first"],
    "confidence": 0.92,
    "context_factors": ["keyword_match", "task_complexity_high", "previous_similar_task"]
  }
}
```

## Zoom-In: Full Trace

### Trace Structure
```
TRACE: [trace_id]
├── REQUEST
│   └── User prompt: "..."
├── ROUTING
│   ├── Detected keywords: [...]
│   ├── Selected route: ...
│   └── Confidence: X%
├── CONTEXT_LOAD
│   ├── Memory queries: [...]
│   ├── Files read: [...]
│   └── Skills activated: [...]
├── EXECUTION
│   ├── Step 1: Tool X → Result summary
│   ├── Step 2: Tool Y → Result summary
│   └── ...
├── OUTPUT
│   ├── Deliverable: ...
│   ├── Quality score: X/10
│   └── Compliance: PASS/FAIL
└── METRICS
    ├── Duration: Xms
    ├── Tokens: X
    └── Tools called: X
```

### Trace Storage
```
Location: .agentic/traces/[date]/[trace_id].json
Retention: 7 days detailed, 30 days summary
```

## Zoom-Out: Aggregate Metrics

### Dashboard Metrics

| Metric | Calculation | Target |
|--------|-------------|--------|
| Success Rate | successes / total | >95% |
| Avg Latency | sum(duration) / count | <30s |
| Hallucination Rate | flagged / total | <2% |
| Cache Hit Rate | cache_hits / cache_attempts | >60% |
| Cost Per Task | sum(tokens) / tasks | Optimize |
| User Intervention | manual_fixes / total | <5% |

### Trend Analysis
```
Track over time:
- Daily success rate
- Weekly cost trends
- Error pattern frequency
- Agent utilization distribution
```

### Alerting Thresholds
```
WARN: success_rate < 90%
WARN: hallucination_rate > 5%
WARN: avg_latency > 60s
CRITICAL: success_rate < 80%
CRITICAL: same_error > 3 times
```

## Quality Sampling Strategy

### Sampling Tiers

| Tier | Sample Rate | Depth | Purpose |
|------|-------------|-------|---------|
| **Full** | 100% | Complete trace | Critical paths |
| **Deep** | 20% | Full trace | Quality assurance |
| **Light** | 100% | Summary only | Aggregate metrics |

### What Gets Full Sampling
```
- Content going to production
- Any error or retry
- User-escalated tasks
- New agent/skill usage
- High-cost operations
```

### What Gets Deep Sampling
```
- Random 20% of all tasks
- Every 5th similar task
- First task of each type per session
```

### Sampling Implementation
```javascript
function shouldDeepSample(task) {
  // Always deep sample these
  if (task.is_production) return true;
  if (task.has_error) return true;
  if (task.is_new_pattern) return true;

  // Random 20%
  return Math.random() < 0.2;
}
```

## Analysis Patterns

### Pattern: Generic Queries
```
Symptom: Low relevance scores on search
Detection: relevance_score < 0.5 in >30% of searches
Root Cause: Queries too broad
Fix: Add context injection to search wrapper
```

### Pattern: Revision Loops
```
Symptom: Same content revised 3+ times
Detection: revision_count > 3 for same artifact
Root Cause: Unclear requirements or quality bar
Fix: Better upfront specification
```

### Pattern: Tool Misuse
```
Symptom: Wrong tool selected
Detection: tool_switch after error
Root Cause: Routing logic gap
Fix: Update intelligent-router patterns
```

### Pattern: Context Loss
```
Symptom: Agent asks for info already provided
Detection: re-request for same data
Root Cause: Handoff didn't preserve context
Fix: Improve interface schemas
```

## User Behavior Metrics

### Track User Interactions
```
- Rephrased queries (clarity issue)
- Session abandonment (friction)
- Manual edits after output (quality gap)
- Repeated similar requests (learning opportunity)
```

### Quality Signals from Users
```
Positive:
- Accepted output without edits
- Continued to next task
- Explicit approval

Negative:
- Extensive manual edits
- "Try again" requests
- Session abandonment
```

## Reporting

### Daily Summary
```markdown
## Agent Observability Report: [date]

### Success Metrics
- Tasks completed: X
- Success rate: X%
- Avg duration: Xms

### Quality Metrics
- Compliance pass rate: X%
- User edit rate: X%
- Hallucination flags: X

### Cost Metrics
- Total tokens: X
- Cost: $X.XX
- Avg per task: X tokens

### Top Issues
1. [Issue] - X occurrences
2. [Issue] - X occurrences

### Recommendations
- [Action item based on data]
```

### Weekly Trends
```
Compare week-over-week:
- Success rate trend
- Cost trend
- Common error evolution
- Agent utilization shifts
```

## Integration

**Calls**:
- execution-tracer (raw trace data)
- memory MCP (metric storage)
- All agents (instrumentation)

**Stores**:
```
mcp__memory__add_observations({
  entityName: "Observability_[date]",
  contents: ["Daily metrics summary"]
})
```

**Files**:
```
.agentic/metrics/daily/[date].json
.agentic/metrics/weekly/[week].json
.agentic/traces/[date]/[trace_id].json
```

## Quick Commands

```bash
# View today's metrics
cat .agentic/metrics/daily/$(date +%Y-%m-%d).json

# Search traces for errors
grep -r "error" .agentic/traces/$(date +%Y-%m-%d)/

# Aggregate success rate
jq '.success_rate' .agentic/metrics/daily/*.json | awk '{sum+=$1} END {print sum/NR}'
```
