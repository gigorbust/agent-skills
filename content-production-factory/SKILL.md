---
name: content-production-factory
description: Use for parallel content production across multiple pages. Orchestrates sub-agents to produce content for MezTal pages at scale. Implements multi-agent patterns for staffing page copy, SEO meta, competitor analysis.
---

# Content Production Factory

## Overview

Orchestrates parallel content production using sub-agents. Each sub-agent handles a specific page or content type in isolation.

## When to Use

- Producing content for multiple pages (2+)
- Parallel SEO optimization
- Batch competitor analysis
- Scale content updates

## Sub-Agent Dispatch Pattern

### For Page Content

```
Dispatch sub-agent for each page type:

1. Service Page Agent:
   - Input: Service name, target keywords
   - Output: Hero copy, benefits, CTA text

2. Location Page Agent:
   - Input: Location name, local keywords
   - Output: Local SEO copy, area-specific content

3. Industry Page Agent:
   - Input: Industry name, pain points
   - Output: Industry-specific messaging
```

### Execution

```markdown
# Sub-agent Prompt Template

You are a content specialist for MezTal staffing.

Context:
- Page Type: [service/location/industry]
- Target: [page name]
- Keywords: [primary, secondary]
- Competitor Analysis: [key differentiators]

Task:
Generate the following content:
1. H1 headline (under 60 chars)
2. Hero paragraph (2-3 sentences)
3. 3 benefit bullets
4. CTA button text
5. Meta title (under 60 chars)
6. Meta description (under 155 chars)

Output as JSON.
```

## Parallel Execution Strategy

### For 96 MezTal Pages

```
Phase 1: Group by Type
├── Service Pages (12)
├── Location Pages (30)
├── Industry Pages (20)
├── Role Pages (25)
└── General Pages (9)

Phase 2: Dispatch Sub-agents
Each group gets parallel sub-agents:
- 3 sub-agents per group
- Each handles ~10 pages
- Total: 15 sub-agents

Phase 3: Aggregate
- Collect all JSON outputs
- Validate consistency
- Generate CMS import file
```

## Integration

**Uses:**
- `subagent-driven-development` - For dispatch
- `fork-terminal` - For parallel sessions

**Output:**
- JSON content for CMS import
- SEO meta data
- Content validation report

## Content Templates by Page Type

### Service Page
```json
{
  "headline": "Expert [Service] Staffing Solutions",
  "hero": "MezTal connects you with pre-vetted [service] professionals...",
  "benefits": ["Vetted talent", "Fast placement", "Industry expertise"],
  "cta": "Get Started Today",
  "metaTitle": "[Service] Staffing Agency | MezTal",
  "metaDesc": "Find qualified [service] professionals..."
}
```

### Location Page
```json
{
  "headline": "[City] Staffing Agency | MezTal",
  "hero": "Your trusted staffing partner in [City]...",
  "benefits": ["Local expertise", "Fast turnaround", "Quality candidates"],
  "cta": "Find Talent in [City]",
  "metaTitle": "[City] Staffing Agency | MezTal",
  "metaDesc": "MezTal provides expert staffing in [City]..."
}
```

## Red Flags

**Never:**
- Dispatch more than 5 parallel sub-agents (context management)
- Produce content without keyword research
- Skip validation step

**Always:**
- Group similar pages together
- Use consistent templates
- Aggregate and validate outputs
