# TaskMaster PRD Mastery — Best Practices & Tips

**Source:** Web research (Dec 2025), Reddit community, TaskMaster.dev docs

---

## 🎯 Core Principle

> **"The quality of your PRD directly determines the quality of generated tasks."**

Invest time upfront in the PRD—it's the source of truth for everything downstream.

---

## PRD File Location

```
.taskmaster/docs/prd.txt     ← Primary location (recommended)
scripts/prd.txt              ← Legacy location
```

After init, find template at: `.taskmaster/templates/example_prd.txt`

---

## PRD Structure (TaskMaster-Optimized)

```markdown
# Project Title

## 1. Overview
Brief description of the project, its purpose, and why it matters.

## 2. Problem Statement
What specific problem does this solve? Who experiences it?

## 3. Goals & Non-Goals
### Goals
- Explicitly what we WILL do
- Measurable outcomes

### Non-Goals
- What is OUT OF SCOPE
- Prevents scope creep

## 4. User Personas
- **Primary:** [Who uses this daily]
- **Secondary:** [Who uses occasionally]

## 5. Success Metrics / KPIs
- Metric 1: [How measured]
- Metric 2: [How measured]

## 6. Features & Requirements

### 6.1 Feature A
- **Description:** What it does
- **Acceptance Criteria:**
  - [ ] Criterion 1
  - [ ] Criterion 2
- **Technical Notes:** Implementation hints

### 6.2 Feature B
[Same structure...]

## 7. Technical Constraints
- Framework: [e.g., Next.js]
- Platform: [e.g., Wix Studio]
- Dependencies: [e.g., must use existing CMS]

## 8. Edge Cases & Error Handling
- What happens when X fails?
- How to handle invalid input?

## 9. Dependencies & Integration Points
- External APIs
- Third-party services
- Internal systems

## 10. Timeline & Milestones
- Phase 1: [Description] — [Date]
- Phase 2: [Description] — [Date]
```

---

## TaskMaster Workflow

### Step 1: Initialize (if new project)
```bash
task-master init --name="Project Name"
```

### Step 2: Parse PRD into Tasks
```bash
task-master parse-prd --input=.taskmaster/docs/prd.txt --num-tasks=15
```
- `--num-tasks`: Adjust based on project size (default 10)

### Step 3: Analyze Complexity
```bash
task-master analyze complexity
```
Uses AI to score each task's difficulty (1-10 scale).

### Step 4: Expand Complex Tasks
```bash
task-master expand <task-id>
```
Breaks down high-complexity tasks into subtasks.

### Step 5: Get Next Task
```bash
task-master next
```
Respects dependencies—only shows ready tasks.

### Step 6: Update Status
```bash
task-master set-status <id> in-progress
task-master set-status <id> done
```
Status options: `pending`, `in-progress`, `review`, `done`, `deferred`, `cancelled`

---

## Reddit Tips & Community Hacks

### 🔥 High-Impact Tips

1. **Spend 2x time on PRD**, save 10x time later
   - *"The more detailed your PRD, the better the AI understands scope"*

2. **Use AI to critique your PRD** before parsing
   - Ask: "What's missing? What's ambiguous? What edge cases aren't covered?"

3. **Maintain consistent formatting**
   - Same heading levels, same bullet style, same acceptance criteria format
   - AI parses patterns better than chaos

4. **Define acronyms and jargon**
   - Don't assume AI knows "CMS" means your specific Wix setup

5. **Include "anti-patterns"**
   - Explicitly state what NOT to do
   - Prevents AI from generating unwanted approaches

### 🧠 Pro Tricks

1. **Tag-based Feature Isolation**
   ```bash
   task-master add-tag --from-branch feature/auth
   task-master use-tag auth
   ```
   Keeps feature work separate.

2. **Subtask Logging**
   ```bash
   task-master update-subtask --id=5.2 --prompt="Discovered edge case: null user"
   ```
   Log findings as you work—builds context for future AI.

3. **Research Tool for Unknowns**
   ```bash
   task-master research "best practices for Wix Velo HTTP functions"
   ```
   Uses AI to gather fresh info.

4. **Multi-Model Strategy**
   - Use Claude for complex reasoning tasks
   - Use faster models for simple task generation

---

## AI-Specific PRD Additions

For projects with AI components, add:

```markdown
## AI Behavior Specification

### Expected Outputs
- Format: [JSON, markdown, etc.]
- Confidence thresholds: [When to ask for clarification]

### Error Handling
- Low-confidence response behavior
- Fallback when AI fails
- Rate limiting strategy

### Ethical Considerations
- Bias mitigation approach
- Data privacy handling
- User consent requirements

### Performance Metrics
- Latency targets: <Xms
- Accuracy targets: >Y%
- Human review required for: [conditions]
```

---

## Common Mistakes to Avoid

| ❌ Mistake | ✅ Fix |
|------------|--------|
| Vague requirements | Use specific, testable criteria |
| Missing dependencies | Explicitly list what must exist first |
| No edge cases | Add "What if X fails?" section |
| Scope creep in PRD | Use Non-Goals section aggressively |
| Inconsistent formatting | Template everything |
| Parsing without review | Always read generated tasks.json |

---

## Integration with Agentic PM

When using `agentic-pm` skill:

1. **PM creates/refines PRD** (never implements)
2. **PM runs `task-master parse-prd`**
3. **PM assigns tasks to experts** via task tags
4. **PM uses `task-master next`** to drive execution
5. **PM updates status** as experts complete work

---

## Quick Reference Commands

| Command | Purpose |
|---------|---------|
| `task-master init` | New project setup |
| `task-master parse-prd --input=X` | Generate tasks from PRD |
| `task-master list` | View all tasks |
| `task-master next` | What should I do now? |
| `task-master show <id>` | Task details |
| `task-master set-status <id> <status>` | Update progress |
| `task-master expand <id>` | Break down complex task |
| `task-master analyze complexity` | Score task difficulty |
| `task-master research "query"` | AI-powered research |
| `task-master sync-readme` | Export to README.md |
