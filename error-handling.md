# Error Handling Skill

## Purpose
Standardized error handling, recovery, and escalation patterns for all agent operations.

## Trigger
Applied to all tool calls, API requests, and agent handoffs.

---

## Error Classification

| Category | Examples | Severity |
|----------|----------|----------|
| **Transient** | Rate limits, timeouts, network blips | Low - Retry |
| **Recoverable** | Invalid input, missing field, format error | Medium - Fix & Retry |
| **Fatal** | Auth failure, resource not found, permission denied | High - Escalate |
| **Safety** | Prompt injection, PII detected, infinite loop | Critical - Block |

---

## Retry Strategy

### Transient Errors
```
Pattern: Exponential backoff with jitter
- Attempt 1: Immediate
- Attempt 2: Wait 1s + random(0-500ms)
- Attempt 3: Wait 2s + random(0-500ms)
- Attempt 4: Wait 4s + random(0-500ms)
- Max attempts: 4
- Total max wait: ~8s
```

### Rate Limits (429)
```
- Read Retry-After header if present
- Default: 60s wait
- Log warning for monitoring
- Consider caching or batching to reduce calls
```

---

## Recovery Patterns

### Self-Healing
```
For recoverable errors:
1. Parse error message
2. Identify fix (e.g., missing required field)
3. Apply fix automatically
4. Retry with corrected input
5. Log the recovery for learning
```

### Graceful Degradation
```
When primary path fails:
1. Try fallback (e.g., different search API)
2. Use cached data if available
3. Reduce scope (partial result vs none)
4. Inform user of limitation
```

---

## Escalation Protocol

### When to Escalate
```
- 3+ consecutive failures on same operation
- Fatal errors (no recovery possible)
- Safety triggers
- Confidence < 50%
```

### Escalation Path
```
1. Log full context (inputs, error, stack trace)
2. Notify user via notify_user tool
3. Suggest alternatives if any
4. Block further execution on that path
5. Update work_status.md with blocker
```

---

## Error Context Template

```json
{
  "timestamp": "2025-12-30T11:53:00Z",
  "operation": "search_web",
  "input": "query terms",
  "error_type": "rate_limit",
  "error_message": "429 Too Many Requests",
  "attempt": 2,
  "recovery_action": "waiting 60s",
  "resolved": false
}
```

---

## Tool-Specific Handling

| Tool | Common Errors | Recovery |
|------|---------------|----------|
| `search_web` | Rate limit, no results | Backoff, rephrase query |
| `read_url_content` | 404, timeout, blocked | Skip source, try alternative |
| `browser_subagent` | Element not found, timeout | Retry with wait, screenshot for debug |
| `mcp_*` | Server unavailable | Log, use fallback if available |
| `run_command` | Non-zero exit | Parse stderr, apply fix |

---

## Logging Requirements

### Always Log
```
- Error category and message
- Operation that failed
- Input that caused failure
- Recovery action taken
- Final outcome (resolved/escalated)
```

### Never Log
```
- Full API keys or tokens
- PII from user data
- Full file contents (use truncated)
```

---

## Integration

Apply in this order:
1. **Before execution**: Validate inputs
2. **During execution**: Catch and classify
3. **After failure**: Attempt recovery
4. **After max retries**: Escalate

Works with:
- `guardrails.md` (safety errors)
- `evaluation-framework.md` (error rate metrics)
- `agentic-research.md` (critique-based recovery)
