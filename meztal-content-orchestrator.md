# MezTal Content Orchestrator

## Purpose
Domain-specific orchestrator for all MezTal content operations. Routes through compliance, manages SEO requirements, and ensures quality.

## Trigger
Detected by `intelligent-router` when request contains: "content", "blog", "pillar", "article", "SEO content"

## Pre-Flight Checks
Before ANY content operation:
```
1. Check MASTER_REGISTRY.json for duplicates
2. Load compliance rules from memory
3. Verify target keyword availability
4. Check CMS_URL_ARCHITECTURE.json for URL structure
```

## Content Pipeline

### Phase 1: Research
```
→ Use agentic-research skill
→ Keyword analysis via seo-specialist
→ Competitor content audit
```

### Phase 2: Planning
```
→ Generate content outline
→ Validate against SEO checklist
→ Confirm with user (if major piece)
```

### Phase 3: Creation
```
→ Draft content using meztal-seo-content skill
→ Apply compliance rules inline
→ Include internal linking structure
```

### Phase 4: Validation
```
→ Run /meztal-audit on draft
→ Check word count, keyword density
→ Verify CTA placement
→ Confirm schema markup ready
```

### Phase 5: Delivery
```
→ Output to designated location
→ Update MASTER_REGISTRY.json
→ Create CMS-ready metadata
```

## Quality Gates
- [ ] No duplicate content (registry check)
- [ ] Keyword in H1, first 100 words
- [ ] Word count meets target (1500+ for pillar)
- [ ] Internal links included
- [ ] CTA present
- [ ] Meta description ≤ 160 chars

## Skills Invoked
| Skill | When |
|-------|------|
| `agentic-research` | Research phase |
| `seo-specialist` | Keyword analysis |
| `meztal-seo-content` | Content creation |
| `compliance-hook` | Validation |

## Integration
- **Called by**: `intelligent-router`
- **Calls**: Content skills, SEO tools, compliance hooks
- **Updates**: MASTER_REGISTRY.json, work_status.md
