---
name: evaluation-system
description: Component-level and end-to-end evaluation for agent outputs. Measures quality at each step and overall success. Use for quality assurance, debugging agent failures, and continuous improvement.
---

# Evaluation System Skill

**Purpose**: Systematic evaluation at component and end-to-end levels

## Evaluation Levels

### Level 1: Component Evaluation
Evaluate individual agent/skill outputs:

| Component | Metrics | Target |
|-----------|---------|--------|
| Research | Relevance, coverage, accuracy | >80% relevant |
| Content | Compliance, quality, SEO | 8+/10 all dimensions |
| Code | Correctness, tests pass, security | 100% tests pass |
| Planning | Completeness, feasibility | All steps actionable |

### Level 2: End-to-End Evaluation
Evaluate final deliverable:

| Deliverable | Success Criteria |
|-------------|------------------|
| Blog Post | Published, compliant, indexed |
| Feature | Working, tested, deployed |
| Report | Accurate, actionable, delivered |

### Level 3: Trace Analysis
Examine intermediate steps:

```
Trace Points:
1. Initial request → Was it understood correctly?
2. Research phase → Were queries effective?
3. Draft phase → Did it follow the plan?
4. Revision phase → Were critiques addressed?
5. Final output → Does it meet requirements?
```

## Evaluation Protocol

### Before Execution
```
1. Define success criteria explicitly
2. Identify evaluation points
3. Set up logging for trace analysis
```

### During Execution
```
1. Log each step with timestamp
2. Record tool calls and responses
3. Note any retries or errors
```

### After Execution
```
1. Run component evaluations
2. Run end-to-end evaluation
3. Analyze trace for patterns
4. Store lessons learned
```

## Evaluation Templates

### Component: Research Quality
```markdown
## Research Evaluation

**Query**: [what was searched]
**Sources Found**: [count]

### Relevance Score: X/10
- [ ] Sources directly address the query
- [ ] Information is current
- [ ] Multiple confirming sources

### Coverage Score: X/10
- [ ] All aspects of query covered
- [ ] No major gaps
- [ ] Depth appropriate to task

### Accuracy Score: X/10
- [ ] Facts verifiable
- [ ] No contradictions
- [ ] Sources reliable

**Overall**: PASS/FAIL
**Issues**: [if any]
```

### Component: Content Quality
```markdown
## Content Evaluation

**Title**: [content title]
**Word Count**: [count]

### Compliance: X/10
- [ ] "approximately 40%" ✓/✗
- [ ] Both cities ✓/✗
- [ ] No forbidden content ✓/✗

### SEO: X/10
- [ ] Title tag optimized
- [ ] Meta description 150-160 chars
- [ ] H1/H2/H3 hierarchy
- [ ] Target keyword placement

### Quality: X/10
- [ ] Professional tone
- [ ] Engaging intro
- [ ] Clear CTA
- [ ] Proper formatting

**Overall**: PASS/FAIL
**Issues**: [if any]
```

### End-to-End: Task Completion
```markdown
## Task Evaluation

**Task**: [task description]
**Started**: [timestamp]
**Completed**: [timestamp]

### Requirements Met: X/X
- [ ] Requirement 1 ✓/✗
- [ ] Requirement 2 ✓/✗
- [ ] Requirement 3 ✓/✗

### Quality Gates Passed: X/X
- [ ] Compliance check ✓/✗
- [ ] Code review ✓/✗
- [ ] Test suite ✓/✗

### Deliverables: X/X
- [ ] Deliverable 1 ✓/✗
- [ ] Deliverable 2 ✓/✗

**Overall**: SUCCESS/PARTIAL/FAIL
**Lessons**: [what to improve]
```

## Trace Analysis Patterns

### Pattern: Generic Queries
```
Symptom: Search queries too broad
Example: "accounting" instead of "nearshore accounting Mexico"
Fix: Add context to queries automatically
```

### Pattern: Revision Loops
```
Symptom: Multiple failed revisions
Example: 3+ attempts to fix same issue
Fix: Break down the problem further
```

### Pattern: Tool Misuse
```
Symptom: Wrong tool selected
Example: Using web search for local file content
Fix: Improve routing logic
```

## Integration

**Calls**:
- reflection-loop (for quality improvement)
- execution-tracer (for trace data)
- memory MCP (store evaluation results)

**Stores**:
```
mcp__memory__create_entities([{
  name: "Evaluation_[date]_[task]",
  entityType: "Evaluation",
  observations: ["Component scores", "E2E result", "Lessons"]
}])
```

## Metrics Dashboard

Track over time:
- Component pass rate
- End-to-end success rate
- Average iterations to completion
- Common failure patterns
