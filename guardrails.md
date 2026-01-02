# Guardrails Skill

## Purpose
Systematic quality and safety validation before, during, and after agent execution.

## Trigger
Applied automatically by orchestrators. Explicitly invoked for high-stakes outputs.

---

## Three-Layer Guardrails

### Layer 1: Deterministic Checks (Code)
Fast, predictable validation:
```
- Output format (JSON schema, markdown structure)
- Length constraints (max tokens, word count)
- Required fields present
- No forbidden patterns (PII, credentials)
```

### Layer 2: LLM Judges
Nuanced evaluation requiring reasoning:
```
Prompt template:
"You are a quality reviewer. Evaluate this output against criteria:
1. Factual accuracy (cite sources if available)
2. Tone appropriateness for [context]
3. Completeness of answer
4. Professional quality

Output: Pass/Fail with specific reasons."

If FAIL → Agent must revise before proceeding
```

### Layer 3: Human-in-the-Loop
Pause for human approval:
```
Triggers:
- Publishing content
- Wix site changes
- External API calls with side effects
- Cost > $X threshold
- Confidence < 70%

Implementation:
→ Use notify_user with BlockedOnUser=true
→ Document decision pending
→ Resume only after explicit approval
```

---

## Safety Patterns

### Prompt Injection Defense
```
- Sanitize user inputs
- Use structured outputs (JSON) over raw text
- Validate tool inputs match expected schemas
```

### Resource Exhaustion Prevention
```
- Max 2 revision loops (agentic-research pattern)
- Timeout limits on external calls
- Token budget per task
```

### Data Protection
```
Scan outputs for:
- PII (email, phone, SSN patterns)
- Credentials (API keys, tokens)
- Internal paths (file:/// references)

Action: Redact or block before delivery
```

---

## Integration Points

| Orchestrator | Guardrail Level |
|--------------|-----------------|
| meztal-content-orchestrator | L1 + L2 (LLM judge for quality) |
| meztal-wix-orchestrator | L1 + L3 (human approval for publish) |
| meztal-analytics-orchestrator | L1 only (deterministic) |
| agentic-research | L2 (self-critique built in) |

## Quality Thresholds
| Metric | Threshold | Action if Fail |
|--------|-----------|----------------|
| LLM judge score | ≥7/10 | Revise |
| Format validation | Pass | Block |
| Safety scan | Clean | Redact/Block |
| Human approval | Explicit yes | Wait |
