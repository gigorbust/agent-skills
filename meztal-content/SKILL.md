---
name: meztal-content
description: Use when creating ANY content for MezTal (pillar pages, spokes, comparisons, blogs, case studies). Enforces compliance, prevents duplicates, routes to correct cookbook, and validates before completion. Triggers on "create content", "write page", "new blog", "pillar page", or any SEO content request.
---

# MezTal Content Skill

**PITER Framework**: Plan → Iterate → Test → Execute → Review

## Pre-Flight Check (MANDATORY)

Before ANY content creation:
1. **Duplicate Check**: `grep -i "[keyword]" /Users/georgegayl/Desktop/Meztal/MASTER_REGISTRY.json`
2. **URL Check**: `grep "[slug]" /Users/georgegayl/Desktop/Meztal/wix-cms/*.json`
3. IF exists → **STOP** and inform user

## Variables

SITE_ID: 24c6a184-1fd5-4b8c-ade1-8f2dae9c8f9e
PROJECT_PATH: /Users/georgegayl/Desktop/Meztal
REGISTRY_PATH: /Users/georgegayl/Desktop/Meztal/MASTER_REGISTRY.json

## Routing (Cookbook Selection)

### Pillar Pages
- **IF**: User requests pillar, comprehensive guide, main service page, or high-volume keyword (>5k search volume)
- **THEN**: Read and execute: `cookbook/pillar-page.md`
- **EXAMPLES**: "create pillar page for PEO services", "write comprehensive guide on nearshoring"

### Spoke Pages
- **IF**: User requests spoke, supporting page, sub-topic, or role-specific page
- **THEN**: Read and execute: `cookbook/spoke-page.md`
- **EXAMPLES**: "create spoke for senior accountant hiring", "write supporting page for AR specialists"

### Comparison Pages
- **IF**: User requests comparison, X vs Y, alternative analysis, or competitive positioning
- **THEN**: Read and execute: `cookbook/comparison-page.md`
- **EXAMPLES**: "create PEO vs EOR comparison", "write Mexico vs India outsourcing comparison"

### Blog Posts
- **IF**: User requests blog, article, thought leadership, or news piece
- **THEN**: Read and execute: `cookbook/blog-post.md`
- **EXAMPLES**: "write blog about time zone advantages", "create article on team retention"

### Case Studies
- **IF**: User requests case study, success story, or client testimonial page
- **THEN**: Read and execute: `cookbook/case-study.md`
- **EXAMPLES**: "create case study for healthcare client", "write success story"

## Workflow

```
1. PLAN
   ├── Run duplicate check (MANDATORY)
   ├── Read appropriate cookbook
   └── Outline content structure

2. ITERATE
   ├── Write first section
   ├── Self-review for compliance
   └── Continue section by section

3. TEST
   ├── Run compliance validation (prompts/compliance-check.md)
   ├── Check word count meets requirements
   └── Verify all sections present

4. EXECUTE
   ├── Write final content to file
   ├── Add to MASTER_REGISTRY.json
   └── Stage for commit

5. REVIEW
   ├── Run /meztal-audit on file
   ├── Fix any issues found
   └── Confirm completion
```

## Compliance (Enforced)

**REQUIRED**:
- "approximately 40% cost savings" (never exact %)
- BOTH Guadalajara AND Mexico City mentioned

**FORBIDDEN**:
- Salary figures ($50k, $80,000, etc.)
- Timeline promises ("in 2 weeks", "by Q2")
- Competitor names (Toptal, Upwork, Fiverr, Freelancer)

## Output Location

| Type | Path | Word Count |
|------|------|------------|
| Pillar | CLAUDE-AI-WORK/PILLARS/v3/ | 2,500-3,500 |
| Spoke | CLAUDE-AI-WORK/SPOKES/v3/ | 1,500-2,000 |
| Comparison | CLAUDE-AI-WORK/COMPARE/ | 2,000-2,500 |
| Blog | CLAUDE-AI-WORK/BLOG/ | 1,000-1,500 |

## Closed-Loop Validation

After writing content:
1. Read `prompts/compliance-check.md` 
2. Run validation against content
3. IF violations found → auto-fix → re-validate
4. IF 3+ failures → escalate to user

## Integration

**Calls**:
- `/meztal-audit` for final validation
- `fork-terminal` if context heavy

**Called By**:
- `/meztal-content` slash command
- `context-orchestrator` when SEO content detected
