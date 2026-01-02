# MezTal Analytics Orchestrator

## Purpose
Domain-specific orchestrator for analytics, reporting, and performance tracking.

## Trigger
Detected by `intelligent-router` when request contains: "analytics", "report", "metrics", "performance", "tracking"

## Capabilities

### Data Collection
```
Sources:
→ Wix Analytics (site traffic, conversions)
→ Search Console (SEO performance)
→ Business Intelligence files
→ CMS collection data
```

### Report Types
| Report | Frequency | Output |
|--------|-----------|--------|
| Traffic Dashboard | Weekly | Markdown summary |
| SEO Performance | Monthly | Keyword rankings |
| Content Performance | Per-piece | Engagement metrics |
| Conversion Funnel | As needed | Optimization recs |

### Analysis Patterns
```
1. Collect raw data
2. Use data-analyst agent for processing
3. Apply agentic-research for insights
4. Generate actionable recommendations
5. Update work_status.md with findings
```

## Skills Invoked
| Skill | When |
|-------|------|
| `data-scientist` | Data processing |
| `agentic-research` | Deep analysis |
| `seo-specialist` | SEO metrics |

## Integration
- **Called by**: `intelligent-router`
- **Uses**: Wix Analytics API, Search Console, internal data
- **Outputs to**: Reports directory, work_status.md
