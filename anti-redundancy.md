# Anti-Redundancy Skill

## Purpose
Prevent duplicate work, wasted effort, and re-implementing completed tasks.

## Trigger
**MANDATORY**: Run checks BEFORE any task execution.

---

## Pre-Execution Checklist

### 1. Check Task Registry
```bash
grep -i "[keyword]" ~/.claude/memory/meztal/task_registry.md
```
If task exists → STOP → Report "Already complete"

### 2. Check File Existence
Before creating any file:
```bash
ls -la [target-path] 2>/dev/null
```
If exists → STOP → Report "File already exists"

### 3. Check Git History
Before implementing a fix:
```bash
git log --oneline --grep="[keyword]" -n 5
```
If commit exists → STOP → Report "Already committed"

### 4. Check Current State (Browser/Live)
Before fixing UI/platform issues:
```
Use browser_subagent to verify current state FIRST
If already fixed → STOP → Report "Already in place"
```

---

## Duplicate Prevention Matrix

| Before This Action | Check This First |
|-------------------|------------------|
| Implement task | task_registry.md |
| Create file | `ls -la [path]` |
| Install package | `npm list [pkg]` or `which [cmd]` |
| Apply code fix | browser verification of current state |
| Create skill | `ls ~/.claude/skills/` |
| Add MCP | Check existing MCP list |

---

## Redundancy Patterns to Avoid

### Pattern 1: Re-implementing Completed Tasks
❌ "Implement Task 29.3" without checking if already done
✅ Check registry → If done, report and move on

### Pattern 2: Recreating Existing Files
❌ `write_to_file` without checking existence
✅ `view_file` or `ls` first → If exists, use `replace_file_content`

### Pattern 3: Re-installing Installed Tools
❌ `npm install -g X` without checking
✅ `which X` or `npm list -g X` first

### Pattern 4: Fixing Already-Fixed Issues
❌ Browser automation to "fix" something
✅ Browser verification FIRST to check current state

---

## Mandatory Agent Protocol

```
BEFORE EVERY TASK:
1. Parse task intent (what are we trying to accomplish?)
2. Search task_registry.md for similar completed work
3. Search learnings.md for relevant patterns
4. Verify current state matches expected "broken" state
5. Only proceed if verification shows work is needed
```

---

## Recovery from Redundant Work

If redundant work is detected mid-execution:
1. STOP immediately
2. Log the redundancy
3. Update task_registry.md if task was missing
4. Report to user what was discovered
5. Do NOT continue the unnecessary work

---

## Integration

This skill is invoked by:
- `intelligent-router` (before routing)
- All domain orchestrators (before executing)
- `agentic-research` (before research)

Updates:
- `task_registry.md` when tasks complete
- `learnings.md` when redundancy is caught
