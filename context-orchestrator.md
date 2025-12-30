# Context Orchestrator Skill

## Purpose
Automatically analyze every request and pull in relevant skills, components, MCPs, tools, and context - without manual invocation.

## Trigger
**ALWAYS** - This skill activates on EVERY prompt automatically.

## Execution Protocol

### Step 1: Request Analysis
For each user request, immediately identify:
- **Domain**: SEO, development, content, data, design, operations
- **Task Type**: Create, analyze, fix, optimize, research, plan
- **Entities**: Files, URLs, APIs, databases, services mentioned
- **Complexity**: Simple (1 tool), Medium (2-3 tools), Complex (4+ tools)

### Step 2: Auto-Pull Relevant Context

#### MCP Servers (check availability and use)
| Server | When to Use |
|--------|-------------|
| `wix-data` | Any Wix CMS, collections, or site operations |
| `wix-mcp` | Wix API, pages, elements, SDK |
| `github` | Repos, PRs, issues, code search |
| `exa` | Web search, code context, research |
| `firecrawl` | Scraping, crawling, extraction |
| `context7` | Library documentation lookup |
| `task-master-mcp` | Task orchestration, planning |

#### Skills to Chain
| Skill | When to Trigger |
|-------|-----------------|
| `meztal-seo-content` | Any SEO content creation for MezTal |
| `task-master-ai` | Task planning, PRD parsing, next task |
| `data-scientist` | Data analysis, cleaning, transformation |
| `seo-specialist` | SEO audits, keyword research, optimization |
| `content-creator` | Blog posts, landing pages, marketing copy |
| `web-developer` | HTML/CSS/JS, responsive design, performance |
| `code-reviewer` | Code quality, security, best practices |
| `systematic-debugging` | Any error or bug investigation |
| `tdd-cycle` | Feature implementation with tests |
| `git-wizard` | Complex git operations, recovery |

#### Component Libraries (for UI work)
- **shadcn/ui**: Forms, Tables, Cards, Dialogs, Accordions
- **Wix Design System**: Wix-native components
- **React patterns**: Hooks, state management

#### Data Sources (for MezTal)
- `MASTER_REGISTRY.json` - Content registry
- `CMS_URL_ARCHITECTURE.json` - Wix URL structure
- `CLAUDE-AI-WORK/intelligence/` - Extracted business intel
- `.taskmaster/tasks/tasks.json` - Current tasks

### Step 3: Pre-fetch Required Context
Before responding, automatically:
1. Check if files need reading → Read them
2. Check if search needed → Use Exa/Grep/Glob
3. Check if MCP data needed → Query relevant server
4. Check if docs needed → Use Context7

### Step 4: Optimal Tool Selection
Choose the BEST tool for each sub-task:
- File search → Glob (not find)
- Content search → Grep (not grep command)
- Web research → Exa or WebSearch
- API docs → Context7
- Complex multi-step → Task agent with Explore

### Step 5: Parallel Execution
When multiple independent operations are needed:
- Launch them in parallel (single message, multiple tool calls)
- Only serialize when there are dependencies

## Auto-Detection Patterns

### SEO Content Request
```
Detected: SEO, content, MezTal, keyword, blog, pillar
→ Auto-pull: meztal-seo-content skill
→ Auto-check: MASTER_REGISTRY.json for duplicates
→ Auto-fetch: keyword data from Architecture_Cleaned_Map
```

### Wix Operations
```
Detected: Wix, CMS, collection, page, site
→ Auto-use: wix-data MCP, wix-mcp
→ Auto-read: WixREADME first
→ Auto-check: CMS_URL_ARCHITECTURE.json
```

### Code/Development
```
Detected: code, function, component, fix, implement
→ Auto-use: Explore agent for context
→ Auto-check: existing patterns in codebase
→ Auto-apply: tdd-cycle or systematic-debugging as needed
```

### Research/Analysis
```
Detected: research, analyze, compare, find, investigate
→ Auto-use: Exa for web, Grep for code
→ Auto-parallel: multiple search vectors
→ Auto-synthesize: combine results
```

## Integration with TaskMaster
When tasks are involved:
1. Check current task: `task-master next`
2. Align work with task context
3. Update task status when work begins/completes
4. Log progress to task subtasks

## Quality Gates
Before every response:
- [ ] Did I check for duplicates? (MezTal content)
- [ ] Did I use the most efficient tools?
- [ ] Did I parallelize where possible?
- [ ] Did I pull relevant context automatically?
- [ ] Is this aligned with current TaskMaster priorities?

## Model Selection
- **Complex reasoning**: Claude Opus 4.5
- **Quick tasks**: Claude Haiku
- **Research**: Perplexity Sonar Pro
- **Agentic**: Grok 4 Fast Reasoning

---

## Smart Tool Selection Matrix

### Keyword → Tool Mapping

| Keyword Pattern | Best Tool(s) | Priority |
|-----------------|--------------|----------|
| SEO, keyword, ranking, SERP | `seo-specialist` skill, `exa` MCP | 1 |
| content, blog, pillar, article | `meztal-seo-content` skill, `/meztal-content` | 1 |
| Wix, CMS, collection, page | `wix-data` MCP, `wix-mcp` | 1 |
| compliance, audit, check | `/meztal-audit`, hooks | 1 |
| task, next, status | `/tm-next`, `task-master-ai` | 1 |
| code, implement, feature | `tdd-cycle` skill, `code-reviewer` | 2 |
| bug, error, fix | `systematic-debugging` skill | 2 |
| research, analyze, compare | `exa` MCP, `data-analyst` agent | 2 |
| competitor, market | `competitive-analyst` agent | 2 |
| git, branch, merge, commit | `git-wizard` skill | 2 |
| plan, design, architect | `writing-plans` skill, `plan-architect` | 2 |
| document, readme, guide | `technical-writer` agent | 3 |
| prompt, AI, generate | `prompt-engineer` agent | 3 |
| parallel, agent, orchestrate | `dispatching-parallel-agents` skill | 3 |

### Context Priority Order

For every request, check in this order:
1. **Project Files** → MASTER_REGISTRY.json, tasks.json
2. **Memory** → mcp__memory__search_nodes for stored context
3. **Recent Files** → What was recently modified
4. **Codebase** → Glob/Grep for patterns
5. **Web** → Exa search for external info

### Subagent Selection Logic

```
IF request contains ("SEO" OR "keyword" OR "ranking"):
    USE: search-specialist agent, seo-specialist skill

IF request contains ("content" OR "blog" OR "article"):
    USE: content-marketer agent, meztal-seo-content skill
    CHECK: MASTER_REGISTRY.json first

IF request contains ("competitor" OR "market"):
    USE: competitive-analyst agent, market-researcher agent

IF request contains ("data" OR "analyze" OR "metrics"):
    USE: data-analyst agent

IF request contains ("code" OR "implement" OR "build"):
    USE: tdd-cycle skill, verification-before-completion

IF request contains ("document" OR "readme" OR "guide"):
    USE: technical-writer agent, document-generator skill
```

### MCP Server Priority

| Server | Auto-Use When |
|--------|---------------|
| `memory` | ALWAYS - check stored context first |
| `wix-data` | Any Wix/CMS operation |
| `exa` | Research, search, external info |
| `github` | Repos, PRs, issues |
| `playwright` | Browser automation, screenshots |
| `sequential-thinking` | Complex multi-step reasoning |

### Slash Command Quick Reference

| Command | Use Case |
|---------|----------|
| `/meztal-content [keyword]` | Generate compliant SEO content |
| `/meztal-audit [file]` | Compliance + quality check |
| `/tm-next` | Get and start next task |
| `/session-end [summary]` | Clean commit + push |

### Automatic Pre-Checks (MezTal)

Before ANY content creation:
```
1. grep -i "[keyword]" MASTER_REGISTRY.json → Duplicate check
2. mcp__memory__search_nodes("Compliance") → Get rules
3. Read CLAUDE-AI-WORK/IDEAS_LOG.md → Recent discoveries
```

Before ANY Wix operation:
```
1. mcp__wix-mcp__WixREADME → Get current docs
2. Check Site ID: 24c6a184-1fd5-4b8c-ade1-8f2dae9c8f9e
```

### Parallel Execution Rules

Execute in PARALLEL when:
- Multiple independent file reads
- Multiple independent searches
- Multiple MCP queries to different servers
- Research + planning (no dependencies)

Execute SEQUENTIALLY when:
- File read → then edit
- Search → then action based on results
- Plan → then implement
- Create → then verify

---

## Feature Decision Framework

### Core 4 Fundamentals
Every agentic feature is built on: **Context, Model, Prompt, Tools**
- Prompts are the primitive - everything is tokens in/tokens out
- Start simple, add complexity only when needed

### When to Use Each Feature

| Feature | Trigger | Context | Best For |
|---------|---------|---------|----------|
| **Skill** | Auto (agent decides) | Progressive disclosure (efficient) | Automatic behavior, repeat expertise, managing resources |
| **Sub-Agent** | Agent delegation | Isolated (lost after task) | Parallel tasks, scale, isolation, context loss OK |
| **MCP Server** | Explicit integration | Heavy (loads on bootup) | External APIs, databases, bundled services |
| **Slash Command** | Manual (user invokes) | Direct injection | One-off tasks, simple prompts, manual compute |

### Decision Quiz

| Scenario | Use | Why |
|----------|-----|-----|
| Extract text from PDFs | Skill | Automatic behavior |
| Connect to Jira/DB | MCP | External integration |
| Security audit at scale | Sub-agent | Scale, isolation, context not needed after |
| Git commit message | Slash Command | Simple one-step task |
| Fix/debug tests at scale | Sub-agent | Scale and isolation |
| Detect style violations | Skill | Encoding repeat behavior |
| Fetch real-time data | MCP | Third-party API |
| Create UI component | Slash Command | One-off task |
| **Anything parallel** | Sub-agent | ONLY feature with parallelization |

### Hierarchy of Composition
```
Skills (Top) → Can bundle Commands, Sub-agents, MCPs
    ↓
Slash Commands (Middle) → Closest to bare metal
    ↓
MCP Servers (Low) → Connectors below skills
```

### Anti-Patterns (Don't Do This)
- ❌ Replacing simple Slash Commands with Skills
- ❌ Building Skill/Sub-agent when Prompt suffices
- ❌ Using Skills for one-off tasks

### Best Practice
- Use Skills to **manage** problems (e.g., "Work Tree Manager" that lists/creates/removes)
- Not just execute single tasks (e.g., "create one tree")
- Skills = opinionated, file-system-based, domain expertise
