---
name: multi-agent-orchestrator
description: Advanced multi-agent coordination for complex tasks. Implements sequential, parallel, manager hierarchy, and all-to-all patterns. Use for any task requiring 3+ agents or complex coordination.
---

# Multi-Agent Orchestrator

**Purpose**: Coordinate multiple agents for complex tasks with clear interfaces and optimal patterns

## Communication Patterns

### 1. Sequential (Pipeline)
```
Agent A → Agent B → Agent C → Output

Use when: Each step depends on previous
Example: Research → Write → Review → Publish
Latency: HIGH (sum of all agents)
Control: HIGH (predictable flow)
```

### 2. Parallel (Fan-out/Fan-in)
```
         ┌→ Agent A ─┐
Request ─┼→ Agent B ─┼→ Merge → Output
         └→ Agent C ─┘

Use when: Independent sub-tasks
Example: Research competitors A, B, C simultaneously
Latency: LOW (max of parallel agents)
Control: MEDIUM (merge complexity)
```

### 3. Manager Hierarchy
```
           Manager
          /   |   \
     Agent A  B    C
         ↓    ↓    ↓
      Report back to Manager
           ↓
      Manager decides next

Use when: Dynamic task assignment needed
Example: Content orchestrator managing writers
Latency: MEDIUM
Control: HIGH (central coordination)
```

### 4. Deep Hierarchy
```
    Executive
        ↓
    Manager
   /       \
Lead A    Lead B
 /  \      /  \
W1  W2   W3  W4

Use when: Large-scale operations
Example: Full site content overhaul
Latency: HIGH
Control: HIGHEST
```

### 5. All-to-All (Mesh)
```
    A ←→ B
    ↕  ✕  ↕
    C ←→ D

Use when: Collaborative refinement
Example: Multiple experts reviewing same doc
Latency: VARIABLE
Control: LOW (emergent behavior)
```

## Interface Definition (Not Vibes)

### Agent Input Schema
```json
{
  "task_id": "uuid",
  "task_type": "research|write|review|code|analyze",
  "input_data": {
    "content": "string or null",
    "context": "object",
    "constraints": ["array of rules"],
    "success_criteria": ["measurable outcomes"]
  },
  "previous_agent_output": "object or null",
  "timeout_ms": 60000,
  "max_retries": 3
}
```

### Agent Output Schema
```json
{
  "task_id": "uuid",
  "status": "success|partial|failed",
  "output_data": {
    "result": "string or object",
    "confidence": 0.0-1.0,
    "artifacts": ["file paths created"]
  },
  "handoff": {
    "next_agent": "agent_name or null",
    "context_for_next": "object",
    "blocking": true|false
  },
  "metrics": {
    "duration_ms": 1234,
    "tokens_used": 5678,
    "tools_called": ["list"]
  }
}
```

## Tool Scoping (Least Privilege)

| Agent Type | Allowed Tools | Forbidden |
|------------|---------------|-----------|
| Researcher | Read, Grep, WebSearch, exa | Write, Edit, Bash |
| Writer | Read, Write | Bash, MCP calls |
| Reviewer | Read, Grep | Write, Edit |
| Developer | All code tools | Production deploy |
| Analyst | Read, Analytics MCPs | Write to content |

## Execution Trace Logging

### Trace Entry Format
```json
{
  "timestamp": "ISO8601",
  "trace_id": "session_task_uuid",
  "agent": "agent_name",
  "action": "start|tool_call|handoff|complete|error",
  "details": {
    "tool": "tool_name",
    "input_summary": "truncated",
    "output_summary": "truncated",
    "duration_ms": 123
  }
}
```

### Trace Analysis
```
After task completion, analyze:
1. Total duration vs sum of agents (parallelization opportunity?)
2. Handoff points (smooth or context loss?)
3. Error recovery (retries successful?)
4. Tool usage (right tools selected?)
```

## Evaluation Framework

### Component Evaluation (Per Agent)
```markdown
## Agent: [name]
**Task**: [what it did]
**Input Quality**: X/10
**Output Quality**: X/10
**Efficiency**: X/10 (tokens/result)
**Errors**: [count and types]
```

### End-to-End Evaluation
```markdown
## Task: [description]
**Agents Used**: [list]
**Pattern**: [sequential/parallel/etc]
**Total Duration**: Xms
**Success**: YES/NO
**Quality Score**: X/10
**Cost**: X tokens
```

## Orchestration Templates

### Template: Content Production
```yaml
pattern: sequential_with_parallel
agents:
  - name: content-strategist
    phase: 1
    parallel_with: null
    output: content_brief

  - name: search-specialist
    phase: 2
    parallel_with: market-researcher
    output: seo_keywords, market_context

  - name: content-creator
    phase: 3
    parallel_with: null
    input_from: [content_brief, seo_keywords, market_context]
    output: draft_content

  - name: reflection-loop
    phase: 4
    parallel_with: null
    output: improved_content

  - name: evaluation-system
    phase: 5
    parallel_with: null
    output: quality_report

success_criteria:
  - compliance_score >= 10
  - seo_score >= 8
  - quality_score >= 8
```

### Template: Research Report
```yaml
pattern: manager_hierarchy
manager: data-analyst
agents:
  - competitive-analyst
  - market-researcher
  - search-specialist

workflow:
  1. Manager decomposes task
  2. Parallel: All specialists research
  3. Manager synthesizes results
  4. technical-writer formats report
```

### Template: Code Feature
```yaml
pattern: sequential
agents:
  - name: wix-developer
    phase: code
  - name: reflection-loop
    phase: review
  - name: front-end-testing
    phase: verify

rollback_on_failure: true
```

## Script Generation Optimization

### Pre-Generation Checks
```
1. Check if similar script exists (avoid duplication)
2. Load relevant patterns from memory
3. Identify required tools/MCPs
4. Set up error handling framework
```

### Generation Rules
```
1. Generate in smallest functional units
2. Test each unit before combining
3. Use typed interfaces (TypeScript preferred)
4. Include error recovery at each step
5. Log all operations for trace
```

### Post-Generation Validation
```
1. Syntax check
2. Dependency check
3. Security scan (no injection vulnerabilities)
4. Performance check (no infinite loops)
5. Integration test
```

## Integration

**Calls**:
- All specialist agents
- execution-tracer (logging)
- evaluation-system (quality)
- memory MCP (pattern storage)

**Called By**:
- Domain orchestrators
- Complex user requests
- Multi-step workflows

## Anti-Patterns

- ❌ Undefined interfaces (vibes-based handoffs)
- ❌ All agents having all tools
- ❌ No trace logging
- ❌ Component-only or E2E-only evaluation
- ❌ Sequential when parallel possible
- ❌ Parallel when order matters
