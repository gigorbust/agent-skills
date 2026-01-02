---
name: reflection-loop
description: Self-critique and improvement pattern. Use after any significant output (content, code, plans) to improve quality through iterative refinement. Triggers on "reflect", "critique", "improve this", or automatically after major deliverables.
---

# Reflection Loop Skill

**Purpose**: Implement the Reflection design pattern for quality improvement

## When to Trigger

- After generating content (blog posts, pillar pages)
- After writing code (Velo, scripts)
- After creating plans
- When user says "reflect", "critique", "improve"
- Automatically after any deliverable >500 words

## Reflection Protocol

### Step 1: Self-Critique
```
Analyze the output against these dimensions:
1. ACCURACY - Are facts correct? Any hallucinations?
2. COMPLETENESS - Does it cover all requirements?
3. CLARITY - Is it easy to understand?
4. QUALITY - Does it meet professional standards?
5. COMPLIANCE - Does it follow project rules?
```

### Step 2: Identify Improvements
```
For each dimension scoring <8/10:
- Identify specific weaknesses
- Propose concrete fixes
- Prioritize by impact
```

### Step 3: Rewrite
```
Apply improvements:
- Fix accuracy issues first (highest priority)
- Add missing content
- Clarify confusing sections
- Polish for quality
- Verify compliance
```

### Step 4: Verify
```
Re-score against dimensions:
- All dimensions should be 8+/10
- If not, loop back to Step 2
- Max 3 iterations
```

## Reflection Templates

### For Content
```markdown
## Self-Critique: [Content Title]

### Accuracy (X/10)
- [ ] All statistics verified
- [ ] No invented claims
- [ ] Sources available if needed

### Completeness (X/10)
- [ ] Covers all required topics
- [ ] Meets word count
- [ ] Has all required sections

### Clarity (X/10)
- [ ] Clear structure
- [ ] No jargon without explanation
- [ ] Logical flow

### Quality (X/10)
- [ ] Professional tone
- [ ] Engaging opening
- [ ] Strong CTA

### Compliance (X/10)
- [ ] "approximately 40%" language
- [ ] Both cities mentioned
- [ ] No forbidden content

**Improvements Needed:**
1. [Specific improvement]
2. [Specific improvement]
```

### For Code
```markdown
## Self-Critique: [Code Description]

### Correctness (X/10)
- [ ] Logic is sound
- [ ] Edge cases handled
- [ ] No obvious bugs

### Completeness (X/10)
- [ ] All requirements met
- [ ] Error handling included
- [ ] Tests pass

### Readability (X/10)
- [ ] Clear naming
- [ ] Appropriate comments
- [ ] Consistent style

### Performance (X/10)
- [ ] No unnecessary loops
- [ ] Efficient algorithms
- [ ] Reasonable resource usage

### Security (X/10)
- [ ] Input validation
- [ ] No injection vulnerabilities
- [ ] Safe data handling

**Improvements Needed:**
1. [Specific improvement]
2. [Specific improvement]
```

## Integration

**Calls**:
- compliance-checker (for MezTal content)
- code-reviewer (for code)
- memory MCP (store lessons learned)

**Called By**:
- content-creator after deliverables
- wix-developer after code
- Any agent after significant output

## Lessons Learned Storage

After each reflection cycle:
```
mcp__memory__add_observations({
  entityName: "Reflection_Lessons",
  contents: ["Pattern: [what improved] → [how fixed]"]
})
```

## Anti-Patterns

- ❌ Superficial critique ("looks good")
- ❌ Skipping verification step
- ❌ More than 3 iterations (diminishing returns)
- ❌ Ignoring compliance dimension for MezTal content
