# Compliance Validation Prompt

Use this template to validate content before finalizing.

## Validation Checklist

### REQUIRED Elements (Must Pass ALL)

```yaml
cost_savings:
  check: Contains "approximately 40% cost savings"
  regex: "approximately 40%"
  
locations:
  check: Mentions BOTH locations
  must_contain:
    - "Guadalajara"
    - "Mexico City"
```

### FORBIDDEN Elements (Must Pass ALL)

```yaml
salary_figures:
  check: No dollar amounts for salaries
  forbidden_patterns:
    - "$[0-9]"
    - "[0-9]+k salary"
    - "[0-9]+K"
  
timeline_promises:
  check: No specific timelines
  forbidden_patterns:
    - "in [0-9]+ weeks"
    - "in [0-9]+ days"
    - "by [A-Z][a-z]+ [0-9]+"
    - "within [0-9]+ business days"
    
competitor_names:
  check: No competitor mentions
  forbidden_words:
    - "Toptal"
    - "Upwork"
    - "Fiverr"
    - "Freelancer"
    - "Deel"
    - "Remote.com"
```

## Self-Correction Protocol

IF violation found:
1. Identify specific violation
2. Generate compliant replacement
3. Apply fix
4. Re-validate

IF 3+ violations after fixes:
- STOP
- Report issues to user
- Request guidance

## Validation Output Format

```
COMPLIANCE CHECK: [FILENAME]
========================
✅ Cost savings language: PASS
✅ Location mentions: PASS  
✅ No salary figures: PASS
✅ No timeline promises: PASS
✅ No competitor names: PASS
------------------------
RESULT: COMPLIANT / NON-COMPLIANT

[If non-compliant:]
VIOLATIONS:
- Line X: [violation description]
- Line Y: [violation description]

AUTO-FIX APPLIED: Yes/No
```
