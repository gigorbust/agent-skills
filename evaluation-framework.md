# Evaluation Framework Skill

## Purpose
Systematic measurement of agent performance at component and end-to-end levels.

## Trigger
Post-execution analysis. Periodic quality audits.

---

## Three-Level Evaluation

### Level 1: Component Metrics
Measure if individual steps work:
```
| Component | Question | Metric |
|-----------|----------|--------|
| Research | "Is the research relevant?" | Source quality score |
| Search | "Did queries find useful results?" | Result relevance |
| Draft | "Is the draft coherent?" | Readability score |
| Critique | "Did it identify real gaps?" | Gap-to-revision ratio |
```

### Level 2: End-to-End Metrics
Measure final output quality:
```
| Outcome | Question | Metric |
|---------|----------|--------|
| Content | "Is the final article good?" | LLM judge + human approval |
| Research | "Did we answer the question?" | Completeness score |
| Code | "Does it work?" | Test pass rate |
| Wix | "Is the site correct?" | Visual verification |
```

### Level 3: Trace Analysis
Examine intermediate steps for patterns:
```
Analyze:
- Search queries (too generic? too narrow?)
- Draft revisions (what changed between versions?)
- Tool calls (failures? retries?)
- Decision points (why this path?)

Patterns to detect:
- Generic queries → poor results
- Multiple revision failures → task too hard
- Unused tool calls → inefficient routing
```

---

## Logging Requirements

### Per-Execution Log
```json
{
  "task_id": "uuid",
  "start_time": "iso8601",
  "end_time": "iso8601",
  "steps": [
    {
      "step": "search",
      "input": "query terms",
      "output": "result count",
      "duration_ms": 1234,
      "success": true
    }
  ],
  "final_score": 8,
  "human_feedback": "approved"
}
```

### Aggregate Metrics (Zoom-out)
```
Track over time:
- Success rate (% tasks completed satisfactorily)
- Hallucination rate (factual errors detected)
- Revision rate (how often critique triggers revise)
- Latency p50/p90/p99
- Cost per task
```

---

## Quality Sampling

Don't inspect every run - sample strategically:
```
- 100% of failures
- 20% of successes (random)
- 100% of high-cost runs
- First 5 runs of any new skill/pattern
```

---

## Integration

| Phase | Evaluation Type |
|-------|-----------------|
| After each step | Component metrics |
| After task completion | E2E metrics |
| Weekly review | Trace analysis + aggregates |

## Improvement Loop
```
1. Collect metrics
2. Identify worst-performing component
3. Hypothesize fix (prompt, model, tool)
4. A/B test change
5. Measure improvement
6. Document in learnings.md
```
