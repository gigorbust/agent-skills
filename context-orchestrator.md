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
