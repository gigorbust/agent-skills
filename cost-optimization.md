# Cost Optimization Skill

## Purpose
Minimize API costs, token usage, and compute while maintaining quality.

## Trigger
Applied to all operations. Aggressive optimization for high-volume tasks.

---

## 1. Attack Big Buckets First

### Cost Priority Matrix
| Operation | Typical Cost | Optimization Priority |
|-----------|-------------|----------------------|
| Multi-search loops | HIGH | 1 - Attack first |
| Long context windows | HIGH | 1 - Trim aggressively |
| Repeated API calls | MEDIUM | 2 - Cache/batch |
| Large file reads | LOW | 3 - Lazy load |

### Before Optimizing Anything Else
```
1. Identify top 3 cost drivers in current workflow
2. Measure token count per operation
3. Focus 80% effort on top 20% cost drivers
4. Ignore low-cost operations until big buckets fixed
```

---

## 2. Model Tiering

### Right-Size Models to Tasks
| Task Complexity | Model | Use Case |
|-----------------|-------|----------|
| Simple | Haiku/Flash | Classification, extraction, simple Q&A |
| Medium | Sonnet/Pro | Code generation, standard analysis |
| Complex | Opus 4.5 | Architecture, multi-step reasoning |
| Agentic | Grok 4 Fast | Tool planning, autonomous loops |

### Auto-Tier Decision
```
IF task is (format check, extraction, simple lookup):
    USE: Haiku
ELIF task is (code, content, standard research):
    USE: Sonnet  
ELIF task is (architecture, complex reasoning, planning):
    USE: Opus
ELIF task is (autonomous, multi-tool, agentic):
    USE: Grok 4 Fast
```

### Never Over-Provision
❌ Using Opus for "format this JSON"
✅ Using Haiku for simple format tasks

---

## 3. Cache Aggressively

### What to Cache
| Data Type | Cache Duration | Strategy |
|-----------|---------------|----------|
| Search results | 1 hour | Keyed by query hash |
| File contents | Until modified | Keyed by path + mtime |
| API responses | 24 hours | Keyed by request hash |
| Computed analyses | Permanent | Keyed by input hash |

### Cache Implementation
```
Location: ~/.claude/cache/

Structure:
~/.claude/cache/
├── search/          # Web search results
├── files/           # Parsed file contents  
├── api/             # External API responses
└── analysis/        # LLM analysis results

Key format: SHA256(input)[:16]
```

### Cache-First Pattern
```
1. Generate cache key from inputs
2. Check cache exists AND not expired
3. If hit → Return cached result
4. If miss → Execute operation → Cache result → Return
```

---

## 4. Batch When Possible

### Batchable Operations
| Operation | Batch Strategy |
|-----------|---------------|
| Multiple search queries | Combine into single request |
| Multiple file reads | Parallel with single LLM call |
| Repeated similar prompts | Template with variable substitution |
| Multiple validations | Single LLM judge call |

### Batching Pattern
```
# Instead of:
for item in items:
    result = llm_call(item)  # N API calls

# Do:
batch_prompt = format_batch(items)
results = llm_call(batch_prompt)  # 1 API call
parsed = parse_batch(results)
```

### When NOT to Batch
- Items have dependencies (need sequential)
- Single item failure should not block others
- Real-time/streaming required

---

## 5. Observability (Zoom-In / Zoom-Out)

### Zoom-In Metrics (Per-Execution)
Log EVERY decision and action:
```json
{
  "trace_id": "abc-123",
  "timestamp": "2025-12-30T12:15:00Z",
  "agent": "researcher",
  "action": "search_web",
  "input": "nearshore accounting best practices",
  "reasoning": "User asked for CFO guide, need current data",
  "output_summary": "3 sources found",
  "tokens_used": 1247,
  "duration_ms": 2340,
  "cache_hit": false,
  "model": "sonnet",
  "cost_estimate": "$0.003"
}
```

### Zoom-Out Metrics (Aggregate)
Track over time:
```
Daily:
  - Total tokens: 45,000
  - Total cost: $1.23
  - Cache hit rate: 67%
  - Avg tokens/task: 2,250
  - Model distribution: Haiku 40%, Sonnet 50%, Opus 10%

Weekly trends:
  - Cost trend: ↓12%
  - Efficiency trend: ↑8%
  - Top cost driver: multi-search loops
```

### Decision Logging (Critical)
Log WHY agents made choices:
```
[2025-12-30T12:15:00] agent:researcher DECISION
  Action: chose search_web over read_url
  Reason: "Query contains 'recent' - need fresh data, not cached"
  Alternative considered: read_url (cached from yesterday)
  Cost impact: +$0.002 (justified by freshness requirement)
```

---

## 6. Quality Sampling Strategy

### Don't Inspect Everything
```
100% inspection: Too expensive for production volume
0% inspection: No quality signal

Optimal: Strategic sampling
```

### Sampling Rules
| Condition | Sample Rate |
|-----------|-------------|
| Failures/errors | 100% |
| High-cost runs (>$0.10) | 100% |
| First 5 runs of new skill | 100% |
| Random success | 20% |
| Routine operations | 5% |

### Deep Inspection Protocol
For sampled runs:
```
1. Full trace review (every step)
2. Token analysis (where spent?)
3. Decision audit (was reasoning sound?)
4. Alternative analysis (cheaper path existed?)
5. Learning extraction (what to cache/optimize?)
```

### Quality Metrics from Samples
```
From sampled runs, derive:
- True success rate (vs claimed)
- Hallucination rate
- Unnecessary token usage %
- Optimization opportunities
```

---

## 7. Output Constraints

### Limit Output Length
```
Bad: "Write a comprehensive analysis..."
Good: "Write analysis in max 500 words"

Bad: "List all considerations..."
Good: "List top 5 considerations"
```

### Structured > Verbose
```
Bad: "Explain your reasoning in detail"
Good: "Return JSON: {decision, reason (50 words max)}"
```

---

## Integration

This skill is referenced by:
- All orchestrators (model selection)
- `intelligent-router` (caching decision)
- `evaluation-framework` (metrics)
- `error-handling` (cost-aware retries)

Logs to:
- `~/.claude/logs/costs/` (per-session)
- `~/.claude/metrics/` (aggregates)
