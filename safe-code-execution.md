# Safe Code Execution Skill

## Purpose
Secure patterns for executing generated code without risking system integrity.

## Trigger
Any operation involving `run_command`, code generation, or script execution.

---

## Sandbox Principles

### 1. Isolation Levels
| Level | Environment | Use Case |
|-------|-------------|----------|
| L1 - Inline | Direct execution | Read-only commands (ls, cat, grep) |
| L2 - Constrained | Resource limits | Write operations, installs |
| L3 - Container | Docker/sandbox | Untrusted code, new scripts |
| L4 - Review | Human approval | Destructive, irreversible operations |

### 2. Always Apply
```
- Timeouts on all executions (max 30s default)
- Memory limits where possible
- No network access for untrusted code
- Whitelist safe libraries only
```

---

## Pre-Execution Validation

### Input Sanitization
```
Before running ANY command:
1. Check for injection patterns (;, &&, ||, |, `, $())
2. Validate file paths are within expected directories
3. Reject commands with sudo/su/chmod 777
4. Block rm -rf without explicit path
```

### Dangerous Pattern Detection
| Pattern | Risk | Action |
|---------|------|--------|
| `rm -rf /` | System destruction | BLOCK |
| `chmod 777` | Security hole | BLOCK |
| `curl \| sh` | Remote exec | BLOCK |
| `eval()` | Injection | WARN + Review |
| Write to system dirs | System corruption | REQUIRE L4 |

---

## Execution Constraints

### Resource Limits
```yaml
defaults:
  timeout_seconds: 30
  max_memory_mb: 512
  max_output_lines: 1000
  network_access: false

overrides_require_approval:
  timeout_seconds: > 60
  network_access: true
  write_to_system: true
```

### Safe Library Whitelist
For Python/Node code execution:
```
Python whitelist:
  - json, csv, re, datetime
  - pandas, numpy (data only)
  - requests (read-only APIs)
  
Forbidden:
  - os.system, subprocess.Popen
  - eval, exec, compile
  - pickle (deserialization attacks)
```

---

## Output Validation

### Post-Execution Checks
```
1. Scan output for sensitive data (PII, credentials)
2. Validate output matches expected format
3. Check for error patterns (stack traces, failures)
4. Verify no unexpected side effects
```

### Structured Returns Only
```
Bad: Return raw stdout to user
Good: Parse stdout → Structured result → Sanitized output
```

---

## Rollback Patterns

### Before Risky Operations
```
1. Create checkpoint (git stash, file backup)
2. Document current state
3. Execute with monitoring
4. If failure → Rollback to checkpoint
5. If success → Clear checkpoint
```

### Atomic Operations
```
For file operations:
1. Write to temp file
2. Validate temp file
3. Atomic move to target
```

---

## Human-in-the-Loop Gates

### Require Explicit Approval For
- Any command with `sudo`
- Writes to system directories
- Network requests to external APIs
- Installations (`npm install`, `pip install`)
- Git push to production branches
- Database write operations

### Approval Protocol
```
1. Present command + reasoning
2. Show potential risks
3. Wait for explicit "yes"
4. Log approval + approver
5. Execute with audit trail
```

---

## Integration

Works with:
- `guardrails.md` (L4 human approval)
- `error-handling.md` (rollback on failure)
- `observability.md` (execution logging)
