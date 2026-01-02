# Multi-Agent Patterns Skill

## Purpose
Define communication and coordination patterns for multi-agent collaboration with clear interfaces, scoped tools, and comprehensive tracing.

## Trigger
When tasks require multiple specialist agents working together.

---

## Communication Patterns

### 1. Sequential (Pipeline)
```
Agent A → Agent B → Agent C
```
**When to use:** Linear dependencies, each step needs previous output
**Example:** Research → Draft → Edit → Publish
**Pros:** Simple, predictable, easy to debug
**Cons:** Slow (no parallelism), single point of failure

### 2. Parallel (Fan-out/Fan-in)
```
     ┌→ Agent A ─┐
Task ├→ Agent B ─┼→ Merge
     └→ Agent C ─┘
```
**When to use:** Independent subtasks, reducing latency
**Example:** Research 3 topics simultaneously
**Pros:** Fast, efficient resource use
**Cons:** Complex merge, potential conflicts

### 3. Manager (Hub-and-Spoke)
```
        Agent A
          ↑↓
Task → Manager → Agent B
          ↑↓
        Agent C
```
**When to use:** Central coordination, dynamic task allocation
**Example:** Content orchestrator delegating to specialists
**Pros:** Flexible, reorderable, maintains control
**Cons:** Manager bottleneck

### 4. Hierarchical (Nested Managers)
```
Manager
  ├→ Team Lead A
  │    ├→ Worker 1
  │    └→ Worker 2
  └→ Team Lead B
       └→ Worker 3
```
**When to use:** Complex projects, multi-level delegation
**Example:** Research lead managing fact-checkers
**Pros:** Scales well, clear ownership
**Cons:** Communication overhead

### 5. All-to-All (Mesh)
```
Agent A ←→ Agent B
   ↕          ↕
Agent C ←→ Agent D
```
**When to use:** Collaborative reasoning, consensus-building
**Example:** Design review with multiple specialists contributing
**Pros:** Rich information sharing, catch blind spots
**Cons:** Coordination complexity, potential infinite loops
**Guard:** Set max rounds (e.g., 3 discussion cycles)

---

## Division of Labor Rules

### Prevent Redundant Work
```
1. Each agent has ONE primary responsibility
2. No overlapping capabilities between agents
3. If two agents could do a task, assign to the specialist
4. Track task assignment in scratchpad
```

### Clear Ownership Matrix
| Task Type | Owner Agent | Collaborators |
|-----------|-------------|---------------|
| Research | Researcher | None |
| Content | Writer | Editor (review only) |
| SEO | SEO Specialist | Researcher (data) |
| Publishing | Publisher | Editor (approval) |
| Debugging | Debugger | None |

---

## Interfaces Not Vibes

### Formal Handoff Schema
```typescript
interface AgentHandoff {
  from_agent: string;        // "researcher"
  to_agent: string;          // "writer"
  task_id: string;           // UUID for tracing
  timestamp: string;         // ISO8601
  
  input: {
    context: string;         // What this is for
    data: Record<string, any>; // Structured payload
    sources?: string[];      // URLs, file paths
  };
  
  instructions: string;      // Clear directive
  constraints: string[];     // Requirements/limits
  expected_output: string;   // What to produce
  
  timeout_ms?: number;       // Max execution time
  retry_on_fail?: boolean;   // Should retry if error
}
```

### Example Handoff
```json
{
  "from_agent": "researcher",
  "to_agent": "writer",
  "task_id": "abc-123",
  "timestamp": "2025-12-30T12:00:00Z",
  "input": {
    "context": "CFO guide on nearshore accounting",
    "data": {
      "key_points": ["Cost savings 40-60%", "Timezone alignment"],
      "statistics": [{"source": "Deloitte", "stat": "47% adoption"}]
    },
    "sources": ["https://deloitte.com/report"]
  },
  "instructions": "Write 1500-word SEO article",
  "constraints": ["Include 3 CTAs", "Target keyword: nearshore accounting"],
  "expected_output": "Markdown article with H2 structure"
}
```

---

## Tool Scoping (Least Privilege)

| Agent | Allowed Tools | Forbidden |
|-------|---------------|-----------|
| Researcher | search_web, read_url_content, agentic-research | write_to_file, run_command |
| Writer | None (pure LLM) | All tools |
| Editor | guardrails (LLM judge) | All other tools |
| Publisher | wix-mcp, browser_subagent | search_web |
| Debugger | run_command, view_file | search_web |

---

## Trace Requirements

### Log Every Handoff
```
[2025-12-30T12:00:00Z] task:abc-123 researcher → writer
  Input: 3 sources, 5 key points
  Duration: 45s
  Status: success
  Tokens: 2,450
```

### Log Every Decision
```
[2025-12-30T12:00:45Z] task:abc-123 writer DECISION
  Reason: "Chose H2 structure over bullet list for SEO"
  Confidence: 85%
```

### Aggregate Metrics
```
Daily:
  - Handoffs: 47
  - Success rate: 94%
  - Avg latency: 23s
  - Redundant work: 2 (4%)
```

---

## Evaluation Levels

### Component Evaluation (Per-Agent)
| Agent | Metric | Threshold |
|-------|--------|-----------|
| Researcher | Source relevance | ≥80% |
| Writer | Draft coherence | ≥7/10 |
| Editor | Error detection rate | ≥90% |
| Publisher | Deploy success | 100% |

### End-to-End Evaluation (Full Pipeline)
| Pipeline | Metric | Threshold |
|----------|--------|-----------|
| Content Pipeline | Final quality score | ≥8/10 |
| Research Pipeline | Answer completeness | ≥85% |
| Publishing Pipeline | Zero errors | 100% |

---

## Script Generation Optimization

### Template for Agent Scripts
```python
# agent_{{role}}.py
from typing import Dict, Any
from dataclasses import dataclass

@dataclass
class AgentConfig:
    name: str = "{{role}}"
    allowed_tools: list = [{{tools}}]
    max_iterations: int = 3
    timeout_ms: int = 30000

async def execute(handoff: AgentHandoff) -> AgentOutput:
    # 1. Validate input against schema
    validate_input(handoff.input)
    
    # 2. Execute core logic with tool constraints
    result = await process(handoff, tools=AgentConfig.allowed_tools)
    
    # 3. Log trace
    log_trace(handoff.task_id, "complete", result.metrics)
    
    # 4. Return structured output
    return AgentOutput(
        data=result.data,
        confidence=result.confidence,
        next_agent=determine_next(handoff)
    )
```

### Generation Rules
1. **Type everything** - No `any` or `unknown`
2. **Validate inputs** - Fail fast on bad data
3. **Constrain outputs** - Match expected format
4. **Include timeouts** - Prevent runaway execution
5. **Log decisions** - Not just actions

---

## Memory Patterns

### Short-term (Scratchpad)
Location: `~/.claude/memory/meztal/scratchpad.md`
- Cross-agent working memory
- Cleared after task completion

### Long-term (Learnings)
Location: `~/.claude/memory/meztal/learnings.md`
- Persistent patterns
- What worked/failed
