---
name: agent-observability
description: Use when monitoring agent performance, tracking costs, debugging chains, or measuring agentic success. Provides patterns for agent observability, metrics collection, and cost tracking.
---

# Agent Observability

## Overview

Monitor, measure, and debug agentic workflows. Essential for production-quality agent systems.

## Key Metrics

### Success Metrics
| Metric | Target | How to Measure |
|:-------|:-------|:---------------|
| Task completion rate | >95% | Tasks completed / tasks attempted |
| First-try success | >80% | No retries needed |
| Context efficiency | <50% window | Tokens used vs available |
| Error rate | <5% | Errors / total actions |

### Cost Metrics
| Metric | Formula |
|:-------|:--------|
| Cost per task | Input tokens + Output tokens * rate |
| Cost per page | Total cost / pages produced |
| Daily spend | Sum of all API calls |

## Observability Tools

### 1. LangSmith (LangChain)
```bash
pip install langsmith
export LANGCHAIN_TRACING_V2=true
export LANGCHAIN_API_KEY=your-key
```
Best for: LangChain workflows, chain debugging

### 2. AgentOps
```bash
pip install agentops
```
Best for: Multi-agent monitoring, session recording

### 3. Helicone
Headers-based, no SDK needed:
```
Helicone-Auth: Bearer <key>
```
Best for: Cost tracking, rate limiting

### 4. Manual Logging
For Claude Code sessions:
```bash
# Session cost estimate (rough)
echo "Session tokens: [input] + [output]"
# Check ~/.claude/stats-cache.json for history
```

## Debugging Patterns

### Chain Failure Analysis
1. Identify failing step
2. Check input/output at that step
3. Verify context availability
4. Test step in isolation

### Context Overflow Detection
Signs:
- Agent forgets earlier context
- Repeated questions
- Inconsistent behavior

Fix: Use `fork-terminal` or `context-manager` skills

### Sub-agent Failure
1. Check sub-agent prompt
2. Verify isolation is appropriate
3. Review output parsing

## Session Tracking

### Manual Session Log
```markdown
## Session: [Date]
- Start: [time]
- End: [time]
- Tasks: [list]
- Tokens: ~[estimate]
- Issues: [any problems]
- Skills used: [list]
```

## Integration

**Pairs with:**
- `context-manager` - Context health
- `fork-terminal` - Session management
- `content-production-factory` - Production monitoring
