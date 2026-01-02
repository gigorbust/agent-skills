---
name: cost-optimizer
description: Optimizes token usage and API costs. Implements model tiering, aggressive caching, and batch processing. Auto-triggers on high-volume tasks or when approaching cost thresholds.
---

# Cost Optimizer Skill

**Purpose**: Minimize token usage and API costs while maintaining quality

## Cost Attack Strategy

### Priority 1: Attack Big Buckets First
```
Identify highest cost operations:
1. Repeated file reads (cache these)
2. Large context windows (trim/summarize)
3. Frequent API calls (batch these)
4. Redundant searches (cache results)
```

### Priority 2: Model Tiering
```
| Task Complexity | Model | Cost Factor |
|-----------------|-------|-------------|
| Simple (formatting, syntax) | Haiku | 1x |
| Standard (coding, writing) | Sonnet | 10x |
| Complex (planning, architecture) | Opus | 75x |
```

### Priority 3: Aggressive Caching
```
Cache everything that doesn't change:
- File contents (until modified)
- Search results (15 min TTL)
- MCP responses (by query hash)
- Generated content (by input hash)
```

### Priority 4: Batch Processing
```
Batch when:
- Multiple similar operations
- Order doesn't matter
- Results can be merged
```

## Model Selection Rules

### Use Haiku For:
- Syntax checking
- Format validation
- Simple transformations
- Quick classifications
- Error message parsing

### Use Sonnet For:
- Code implementation
- Content writing
- Standard analysis
- Most daily tasks

### Use Opus For:
- Architecture planning
- Complex debugging
- Strategic decisions
- Multi-step reasoning
- Plan Mode

## Caching Strategy

### Cache Layers
```
Layer 1: In-Memory (session)
├── File contents by path+mtime
├── Tool results by input hash
└── TTL: Session lifetime

Layer 2: Memory MCP (persistent)
├── Frequently accessed patterns
├── Stable reference data
└── TTL: Until invalidated

Layer 3: File System (long-term)
├── Generated content
├── Analysis results
└── TTL: Manual cleanup
```

### Cache Keys
```javascript
// File cache key
`file:${path}:${mtime}`

// Search cache key
`search:${hash(query)}:${timestamp_bucket}`

// MCP cache key
`mcp:${server}:${hash(params)}`
```

### Cache Invalidation
```
Invalidate on:
- File modification detected
- Explicit user request
- TTL expiration
- Error in cached data
```

## Batch Processing Patterns

### File Operations
```
// Instead of:
files.forEach(f => read(f))  // N calls

// Use:
readMultiple(files)  // 1 call
```

### MCP Calls
```
// Instead of:
items.forEach(i => wix.insert(i))  // N calls

// Use:
wix.bulkInsert(items)  // 1 call
```

### Content Generation
```
// Instead of:
keywords.forEach(k => generatePost(k))  // N calls

// Use:
generatePosts(keywords, template)  // Batched with shared context
```

## Context Optimization

### Trim Strategies
```
1. Remove resolved conversation history
2. Summarize large file contents
3. Use file references instead of full content
4. Lazy load only when needed
```

### Context Budget
```
Total: 200k tokens
Reserved:
- System prompt: ~5k
- CLAUDE.md: ~3k
- Active rules: ~2k
Available: ~190k for task

Warning threshold: 60% (114k)
Critical threshold: 80% (152k)
```

### When Approaching Limit
```
1. Summarize conversation so far
2. Save state to reference file
3. Clear context
4. Resume from reference file
```

## Cost Tracking

### Per-Operation Logging
```json
{
  "operation": "content_generation",
  "model": "sonnet",
  "input_tokens": 1234,
  "output_tokens": 5678,
  "estimated_cost": 0.0234,
  "cached": false
}
```

### Session Totals
```
Track:
- Total tokens used
- Cost by model tier
- Cache hit rate
- Batch efficiency
```

### Optimization Signals
```
If cache_hit_rate < 50%:
  → Identify frequently repeated operations
  → Add to cache layer

If haiku_eligible > 30%:
  → More tasks could use smaller model
  → Review model selection

If batch_opportunity > 20%:
  → Operations could be batched
  → Review loop patterns
```

## Implementation

### Before Any Task
```
1. Check if result already cached
2. Determine minimum model needed
3. Identify batch opportunities
4. Set context budget
```

### During Task
```
1. Use smallest model possible
2. Cache intermediate results
3. Batch similar operations
4. Monitor token usage
```

### After Task
```
1. Cache final results
2. Log cost metrics
3. Identify optimization opportunities
4. Update patterns
```

## Integration

**Calls**:
- All tools (wraps for caching)
- memory MCP (persistent cache)
- execution-tracer (cost logging)

**Metrics Stored**:
```
mcp__memory__add_observations({
  entityName: "Cost_Metrics",
  contents: ["Session cost: X tokens", "Cache hit: Y%"]
})
```

## Quick Reference

### Cost Reduction Checklist
- [ ] Using appropriate model tier?
- [ ] Results cached where possible?
- [ ] Operations batched?
- [ ] Context trimmed?
- [ ] Redundant reads eliminated?

### Model Selection Quick Guide
| Question | Answer |
|----------|--------|
| "Is this formatting/syntax?" | Haiku |
| "Is this standard work?" | Sonnet |
| "Is this planning/complex?" | Opus |
