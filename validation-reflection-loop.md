# Validation-Reflection Loop Skill

## Purpose
Systematic validation with reflection to catch errors, improve quality, and learn from outcomes.

## Trigger
After any significant output: content, code, analysis, decisions.

---

## The Loop Pattern

```
┌─────────────────────────────────────────────┐
│                                             │
│  Generate → Validate → Reflect → Revise ──┐ │
│      ↑                                    │ │
│      └────────────────────────────────────┘ │
│                                             │
│  Exit when: Score ≥ threshold OR max loops  │
└─────────────────────────────────────────────┘
```

---

## Phase 1: Generation
```
Input: Task specification
Output: Initial draft/code/analysis
```

## Phase 2: Validation (Multi-Layer)

### Layer A: Deterministic Checks
```
Automated, instant validation:
- Format correct? (JSON valid, Markdown proper)
- Length within bounds?
- Required fields present?
- No forbidden patterns?
```

### Layer B: LLM Self-Critique
```
Prompt: "You are a critical reviewer. Evaluate this output:

[OUTPUT]

Score 1-10 on:
1. Correctness (factual accuracy)
2. Completeness (all requirements met)
3. Quality (professional standard)
4. Safety (no harmful content)

For each score < 8, explain specific gaps.
List 3 specific improvements needed.
Provide overall score and pass/fail decision."
```

### Layer C: External Validation (if applicable)
```
For code:
- Syntax check (linter)
- Type check
- Unit test run
- Security scan

For content:
- Plagiarism check
- Fact verification
- SEO validation
```

---

## Phase 3: Reflection

### Structured Reflection Template
```json
{
  "scores": {
    "correctness": 7,
    "completeness": 8,
    "quality": 6,
    "safety": 10
  },
  "overall_score": 7.75,
  "pass_threshold": 8,
  "passed": false,
  
  "gaps_identified": [
    "Missing citation for market size claim",
    "Second paragraph too verbose",
    "CTA not compelling enough"
  ],
  
  "improvement_plan": [
    "Add Deloitte source for market data",
    "Condense paragraph 2 to 3 sentences",
    "Strengthen CTA with urgency element"
  ],
  
  "root_cause": "Rushed generation without source verification"
}
```

### Learn from Reflection
```
If same gap appears 3+ times:
→ Add to learnings.md as pattern
→ Update generation prompts to prevent
→ Consider adding to deterministic checks
```

---

## Phase 4: Revision

### Targeted Fixes Only
```
❌ Regenerate entire output
✅ Fix only identified gaps

For each gap in improvement_plan:
1. Locate specific section to fix
2. Apply minimal targeted change
3. Verify fix addresses gap
```

### Revision Limits
```
max_revision_loops: 2
reasoning: Diminishing returns after 2 passes

After 2 loops:
- If score ≥ 7: Accept with caveats noted
- If score < 7: Escalate to human review
```

---

## Loop Exit Conditions

| Condition | Action |
|-----------|--------|
| Score ≥ threshold | ✅ Accept output |
| Max loops reached, score ≥ 7 | ⚠️ Accept with notes |
| Max loops reached, score < 7 | 🚫 Escalate to human |
| Critical safety issue | 🚫 Block immediately |

---

## Feedback Integration

### Per-Loop Logging
```
[Loop 1] Score: 6.5 | Gaps: 3 | Action: Revise
[Loop 2] Score: 7.8 | Gaps: 1 | Action: Revise  
[Loop 3] Score: 8.5 | Gaps: 0 | Action: Accept
```

### Cross-Task Learning
```
Aggregate validation patterns:
- What gaps recur?
- Which validation catches most issues?
- What prompts produce highest first-pass scores?
```

---

## Integration

This skill is invoked by:
- `agentic-research.md` (critique step)
- `guardrails.md` (LLM judge layer)
- All orchestrators (post-generation)

Logs to:
- `~/.claude/logs/validations/`
- `learnings.md` (persistent patterns)
