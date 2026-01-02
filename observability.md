# Observability Skill

## Purpose
Comprehensive logging and metrics for agent operations. Both zoom-in (per-execution) and zoom-out (aggregate) visibility.

---

## 1. Trace Logging (Zoom-In)

### Every Agent Action Log
```json
{
  "trace_id": "uuid",
  "parent_trace_id": "uuid or null",
  "timestamp": "ISO8601",
  "agent": "agent_name",
  "action": "tool_name or decision",
  "phase": "planning|execution|verification",
  
  "input": {
    "summary": "Brief description",
    "token_count": 500
  },
  
  "output": {
    "summary": "Brief description",
    "token_count": 1200,
    "success": true
  },
  
  "reasoning": "WHY this action was taken",
  "alternatives_considered": ["option_a", "option_b"],
  "confidence": 0.85,
  
  "metrics": {
    "duration_ms": 2340,
    "model": "sonnet",
    "tokens_in": 500,
    "tokens_out": 1200,
    "cost_estimate": "$0.003",
    "cache_hit": false
  }
}
```

### Decision Logging (Critical)
Log reasoning for non-obvious choices:
```
[TIMESTAMP] DECISION agent:researcher
  Context: User asked for "CFO guide on nearshore"
  Decision: Use search_web instead of cached data
  Reason: Query implies need for current information
  Alternatives: 
    - Use cached (cheaper, but stale)
    - Use both (expensive, redundant)
  Cost impact: +$0.002
  Confidence: 90%
```

---

## 2. Aggregate Metrics (Zoom-Out)

### Session Metrics
```yaml
session_id: "abc-123"
start_time: "2025-12-30T12:00:00Z"
end_time: "2025-12-30T12:30:00Z"

totals:
  tokens_in: 15,000
  tokens_out: 8,000
  total_tokens: 23,000
  cost_estimate: "$0.45"
  duration_minutes: 30
  
operations:
  tool_calls: 47
  llm_calls: 23
  cache_hits: 12
  cache_misses: 11
  
efficiency:
  cache_hit_rate: 52%
  avg_tokens_per_task: 4,600
  model_distribution:
    haiku: 35%
    sonnet: 55%
    opus: 10%

quality:
  success_rate: 94%
  revision_rate: 15%
  human_overrides: 2
```

### Weekly Trends
```yaml
week_of: "2025-12-30"

cost_trend:
  this_week: "$12.50"
  last_week: "$15.00"
  change: "-16%"

efficiency_trend:
  cache_hit_rate: 67% (up from 52%)
  avg_tokens: 3,200 (down from 4,600)
  
top_cost_drivers:
  1: "multi-search loops - $5.20"
  2: "long context analysis - $3.10"
  3: "content generation - $2.40"

optimization_opportunities:
  - "Cache search results for repeated queries"
  - "Use Haiku for format validation"
  - "Batch similar content requests"
```

---

## 3. Quality Sampling

### Sampling Strategy
| Condition | Rate | Reason |
|-----------|------|--------|
| Errors/failures | 100% | Must understand all failures |
| High-cost (>$0.10) | 100% | Worth inspecting expensive runs |
| New skill (first 5) | 100% | Validate new patterns |
| Random success | 20% | Spot-check quality |
| Routine ops | 5% | Minimal overhead |

### Deep Inspection Checklist
For sampled runs:
```
[ ] Full trace reviewed
[ ] Token usage analyzed
[ ] Decision reasoning validated
[ ] Cheaper alternatives identified?
[ ] Learnings extracted
[ ] Patterns documented
```

---

## 4. User Behavior Metrics

### Track Interaction Patterns
```yaml
user_metrics:
  rephrased_queries: 3 (indicates confusion)
  session_length: 45min
  edit_requests: 2 (indicates quality issues)
  approval_rate: 95%
  override_rate: 5%
```

---

## 5. Log Locations

```
~/.claude/logs/
├── traces/           # Per-execution traces
│   └── 2025-12-30/
│       └── trace-abc123.json
├── decisions/        # Decision audit log
│   └── 2025-12-30.jsonl
├── metrics/          # Aggregate metrics
│   └── weekly-2025-w52.yaml
└── samples/          # Quality samples
    └── deep-inspect-abc123.md
```

---

## 6. Alerting Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| Cost per task | >$0.10 | >$0.50 |
| Token count | >10,000 | >50,000 |
| Failure rate | >10% | >25% |
| Cache hit rate | <40% | <20% |
| Revision loops | >2 | >3 |

---

## Integration

Referenced by:
- `cost-optimization.md` (metrics input)
- `evaluation-framework.md` (quality data)
- `error-handling.md` (failure logging)
- All orchestrators (trace injection)
