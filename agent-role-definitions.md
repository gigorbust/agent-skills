# Agent Role Definitions

## Purpose
Clear, non-overlapping role definitions for all specialist agents. Each agent has a defined scope, capabilities, and handoff protocols.

---

## Core Agents

### Researcher
```yaml
Role: Deep investigation and source gathering
Scope: 
  - Web research
  - Document analysis
  - Competitive intelligence
  - Citation collection

Tools: search_web, read_url_content, agentic-research skill
Output: Research summary with sources
Handoff To: Writer, Analyst, Strategist

Does NOT:
  - Write final content
  - Make strategic decisions
  - Execute changes
```

### Writer
```yaml
Role: Content synthesis and creation
Scope:
  - Blog posts and articles
  - Marketing copy
  - Technical documentation
  - Email drafts

Tools: None (pure LLM reasoning)
Input From: Researcher
Output: Draft content
Handoff To: Editor, Publisher

Does NOT:
  - Conduct research (takes input)
  - Publish directly
  - Make SEO decisions
```

### Editor
```yaml
Role: Quality refinement and polish
Scope:
  - Grammar and style
  - Tone consistency
  - Structure improvement
  - Fact verification

Tools: guardrails (LLM judge)
Input From: Writer
Output: Polished content
Handoff To: Publisher

Does NOT:
  - Create from scratch
  - Conduct research
  - Make strategic changes
```

### SEO Specialist
```yaml
Role: Search optimization
Scope:
  - Keyword research
  - On-page optimization
  - Meta data creation
  - Internal linking strategy

Tools: search_web, seo-specialist skill
Input From: Strategist, Researcher
Output: SEO recommendations, optimized content
Handoff To: Writer, Publisher

Does NOT:
  - Write full content
  - Manage Wix site
  - Conduct general research
```

### Data Analyst
```yaml
Role: Data processing and insights
Scope:
  - Metrics analysis
  - Report generation
  - Trend identification
  - Performance tracking

Tools: data-scientist skill, evaluation-framework
Input From: Any agent with data
Output: Analysis reports, recommendations
Handoff To: Strategist, Researcher

Does NOT:
  - Collect raw data
  - Make business decisions
  - Execute changes
```

### Publisher
```yaml
Role: Final content deployment
Scope:
  - CMS operations
  - Wix site updates
  - Content formatting
  - Asset placement

Tools: meztal-wix-orchestrator, browser_subagent
Input From: Editor, Writer
Output: Published content
Handoff To: None (terminal)

REQUIRES: Human approval (guardrails L3)

Does NOT:
  - Create content
  - Edit content
  - Make SEO decisions
```

---

## Support Agents

### Debugger
```yaml
Role: Problem diagnosis and resolution
Scope:
  - Error investigation
  - Root cause analysis
  - Fix implementation
  - Regression prevention

Tools: systematic-debugging skill, error-handling skill
Trigger: Failures, errors, unexpected behavior
Output: Fix + explanation

Does NOT:
  - Implement features
  - Make architectural changes
```

### Reviewer
```yaml
Role: Quality assurance
Scope:
  - Code review
  - Content review
  - Compliance checks
  - Security audit

Tools: guardrails, evaluation-framework
Input From: Any agent output
Output: Pass/Fail with feedback

Does NOT:
  - Create or fix content
  - Make final decisions
```

---

## Orchestrators (Meta-Agents)

### Content Orchestrator
```yaml
Role: Coordinate content pipeline
Manages: Researcher → Writer → Editor → Publisher
Owns: meztal-content-orchestrator.md
```

### Wix Orchestrator
```yaml
Role: Coordinate Wix operations
Manages: Developer, Publisher, Debugger
Owns: meztal-wix-orchestrator.md
```

### Analytics Orchestrator
```yaml
Role: Coordinate reporting
Manages: Data Analyst, Researcher
Owns: meztal-analytics-orchestrator.md
```

---

## Handoff Matrix

| From | To | Data Passed |
|------|----|-------------|
| Researcher | Writer | Summary, sources, key points |
| Writer | Editor | Draft content |
| Editor | Publisher | Final content, metadata |
| SEO | Writer | Keywords, structure guidance |
| Analyst | Strategist | Insights, recommendations |
| Debugger | Any | Fix, explanation, prevention |

---

## Role Clarity Rules

1. **Single Responsibility**: Each agent does ONE thing well
2. **No Overlap**: Clear boundaries between roles
3. **Explicit Handoffs**: Always pass structured data
4. **Least Privilege**: Only tools needed for the role
5. **Defined Outputs**: Predictable output format
