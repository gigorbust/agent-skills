# Always-On Error Handler

## Purpose
Automatically engages error handling for all tool operations, ensuring:
- All errors are logged to `.agentic/logs/errors.jsonl`
- Transient errors trigger automatic retry
- Validation errors attempt self-fix
- Critical errors escalate to user

## Activation
This skill is automatically engaged via the `PostToolUse` hook.

## Error Classification

| Type | Behavior | Retry? |
|:-----|:---------|:-------|
| TRANSIENT | Network/timeout - retry with backoff | ✅ 3 attempts |
| VALIDATION | Content/code error - attempt auto-fix | ✅ 3 iterations |
| PERMANENT | Auth/config - log and fail | ❌ |
| CRITICAL | Security/data - escalate to human | ❌ |

## Integration

### Hook Configuration (settings.json)
```json
{
  "hooks": {
    "PostToolUse": ["~/.claude/skills/always-on-error-handler/handler.sh"]
  }
}
```

### Error Log Location
```
~/Desktop/Meztal/.agentic/logs/errors.jsonl
```

### Manual Invocation
```bash
# Check recent errors
tail -20 ~/Desktop/Meztal/.agentic/logs/errors.jsonl | jq .

# Run health check
node ~/Desktop/Meztal/lib/health-monitor.js
```

## Wrapped Operations

When active, all tool operations are wrapped with:
1. **Pre-execution check** - Validate preconditions
2. **Error capture** - Catch and classify errors
3. **Recovery attempt** - Based on error type
4. **Logging** - Record to JSONL with full context
5. **Escalation** - Alert user for critical errors

## Recovery Strategies

### Retry with Backoff (TRANSIENT)
```
Attempt 1: immediate
Attempt 2: 1 second delay
Attempt 3: 2 second delay
```

### Validate and Fix (VALIDATION)
```
Iteration 1: Run validator → identify issues
Iteration 2: Apply fixer → re-validate
Iteration 3: Final attempt → succeed or escalate
```

## Error Log Schema
```json
{
  "timestamp": "2025-12-30T04:45:00Z",
  "level": "ERROR",
  "agent": "content-creator",
  "task_id": "task-3",
  "operation": "create_pillar_page",
  "error": {
    "type": "ValidationError",
    "message": "Missing compliance phrase",
    "classification": "VALIDATION",
    "context": {}
  },
  "recovery": {
    "attempted": true,
    "strategy": "validate_and_fix",
    "success": true
  }
}
```

## Session Startup
On each session, run health check:
```bash
node ~/Desktop/Meztal/lib/health-monitor.js
```
