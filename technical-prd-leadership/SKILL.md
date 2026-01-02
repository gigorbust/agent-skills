# Skill: Technical PRD Leadership

## Description
Master skill for leading the creation of Technical PRDs and Architecture documents using the **BMAD Method** agent workflow. Routes to the optimal agent based on project phase.

## BMAD Agent Workflow (Phase Order)

```
Analyst → PM → Architect → PO → SM → Dev → QA
```

| Phase | Agent | Command | Output |
|-------|-------|---------|--------|
| 1. Ideation | Analyst ("Mary") | `/analyst` | Project Brief |
| 2. Requirements | PM | `/pm` → `create PRD` | PRD with Epics/Stories |
| 3. Architecture | Architect | `/architect` | Tech Stack, Schema, Structure |
| 4. Alignment | PO | `/po` → `run checklist` | Gap Analysis |
| 5. Story Creation | SM | `/sm` → `draft` | Developer Stories |
| 6. Implementation | Dev ("James") | `/dev` → `develop story` | Code |
| 7. Review | QA ("Quinn") | `/qa` → `review` | Compliance Report |

## Context Engineering Principles

1. **Sharding**: Large PRDs/Architecture split via `mdtree explode` into small files
2. **Context Clearing**: Fresh chat session between agents (`/clear`)
3. **Just-in-Time Loading**: Agents only load files they need
4. **Load Always Files**: Dev always loads Tech Stack + Coding Standards

## When to Use
Activate when user requests:
- PRD creation, product requirements, feature specs
- Technical architecture, system design
- Brainstorming (use Analyst's 20 techniques: Six Hats, 5 W's, etc.)
- Implementation planning

## Decision Framework

```
┌─────────────────────────────────────────────────────────────┐
│                    PRD/Architecture Request                  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌───────────────────────────────┐
              │   Full PRD with stakeholder   │
              │     discovery needed?         │
              └───────────────────────────────┘
                    │                    │
                   YES                   NO
                    │                    │
                    ▼                    ▼
        ┌─────────────────┐    ┌──────────────────────────┐
        │ BMAD create-prd │    │  Quick implementation    │
        │ (8-11 steps,    │    │  plan for known scope?   │
        │  collaborative) │    └──────────────────────────┘
        └─────────────────┘              │          │
                                        YES         NO
                                         │          │
                                         ▼          ▼
                              ┌─────────────┐  ┌─────────────────┐
                              │plan-architect│  │BMAD architecture│
                              │(quick 2-5min │  │(decision-focused│
                              │ tasks)       │  │ 8 steps)        │
                              └─────────────┘  └─────────────────┘
```

## Priority Order

### 1. BMAD Workflows (Default for Comprehensive Work)
**Use `/bmad-bmm-workflows-create-prd`** when:
- New product or major feature
- Multiple stakeholders involved
- Need structured collaborative discovery
- Creating foundational project documentation

**Use `/bmad-bmm-workflows-create-architecture`** when:
- Technical decisions needed before implementation
- Preventing AI agent implementation conflicts
- Complex system with multiple components

### 2. Plan-Architect (Quick Implementation Plans)
**Use plan-architect skill** when:
- Scope already defined
- Need bite-sized tasks (2-5 min each)
- Implementation plan for a single feature/fix
- User wants to start coding quickly

### 3. TaskMaster Integration
**After PRD is created**, use TaskMaster workflow:
```bash
task-master parse-prd --input=.taskmaster/docs/prd.txt --num-tasks=15
task-master analyze complexity
task-master expand <high-complexity-task-id>
```

## Routing Commands

| Need | Command |
|------|---------|
| Full PRD | `/bmad-bmm-workflows-create-prd` |
| Architecture | `/bmad-bmm-workflows-create-architecture` |
| Quick Plan | Use `plan-architect` skill directly |
| Parse to Tasks | `task-master parse-prd` |

## Anti-Patterns

❌ **Never** create a PRD without asking about scope first
❌ **Never** skip architecture for complex multi-component systems
❌ **Never** jump to implementation without verification step defined
❌ **Never** create implementation plans with vague "and" tasks (break them up)

## Integration with Agentic PM

When operating as Agentic PM:
1. Lead PRD creation using this skill
2. Never implement yourself—delegate to specialist agents
3. Use TaskMaster to track expert assignments
4. Review work via `/bmad-bmm-workflows-code-review`
