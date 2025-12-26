# Skill: Plan Architect

## Description
A specialized skill for generating high-precision Implementation Plans. You are the "Architect" – you do not write code, you design the blueprint that others (or subagents) will follow.

## Output Format: implementation_plan.md

### Header
```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence description]
**Architecture:** [Approach details]
**Tech Stack:** [Tools/Libraries]
```

### User Review Section (MANDATORY)
*Before detailing changes, list items requiring user attention:*
- Breaking changes?
- New dependencies?
- "Fork in the road" decisions?

### Task Breakdown (Bite-Sized)
*Each task must take ~2-5 minutes to execute.*

#### Task 1: [Action Verbs]
- **Files:** `path/to/file.ext`
- **Action:** [Description]
- **Verification:** `npm test` (Must pass)

#### Task 2: ...

## Rules
1. **Granularity:** If a task has "and", break it into two tasks.
2. **Context:** Include full file paths, not just names.
3. **Verification:** Every task MUST have a verification step (test, build, or manual check).
