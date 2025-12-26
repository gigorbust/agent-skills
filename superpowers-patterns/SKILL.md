---
name: superpowers-patterns
description: Systematic development patterns for TDD, debugging, code review, and task planning. Use when writing tests first, debugging errors, reviewing code, planning implementations, or needing development discipline. Triggers on terms like "TDD", "test first", "debug", "systematic", "code review", "implementation plan", "red green refactor".
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Superpowers Development Patterns

## Version History
- v2.0.0 (2025-12-25): Added trigger terms, expanded patterns, full documentation
- v1.0.0 (2025-12-24): Initial release from obra/superpowers

## Pattern 1: Test-Driven Development (TDD)

### The Non-Negotiable Rule
**Code written before tests = DELETE IT and start over**

### RED-GREEN-REFACTOR Cycle

**1. RED Phase (Write failing test)**
- Define expected behavior precisely
- Create minimal test that fails
- WATCH IT FAIL (this is critical - proves test works)

**2. GREEN Phase (Make it pass)**
- Write ONLY code needed to pass the test
- No extra features
- No premature optimization
- Resist the urge to "improve"

**3. REFACTOR Phase (Clean up)**
- Keep tests passing
- Remove duplication
- Improve naming
- Never change behavior

### Why Tests-After Don't Work
- Passing tests immediately prove nothing
- They verify what was built, not what should be built
- Miss edge cases you forgot to consider
- Create false confidence

### TDD Commands
```bash
# Start TDD cycle
/tdd-start [feature description]
```

## Pattern 2: Systematic Debugging

### The Iron Law
**Never guess. Never shotgun. Always investigate first.**

### Four Mandatory Phases

**Phase 1: Root Cause Investigation**
- Read error messages THOROUGHLY (every word)
- Reproduce consistently (same inputs → same error)
- Review recent changes (git diff, git log)
- Trace backward to origin (where did it start?)

**Phase 2: Pattern Analysis**
- Find working examples in codebase
- Compare systematically to broken code
- Read reference implementations COMPLETELY
- Note every difference, no matter how small

**Phase 3: Hypothesis Testing**
- Form SPECIFIC hypothesis ("X causes Y because Z")
- Test with MINIMAL change (one variable at a time)
- Verify before proceeding
- NEVER combine multiple fixes

**Phase 4: Implementation**
- Create failing test FIRST (that reproduces the bug)
- Single targeted fix
- Verify fix
- Ensure no regressions

### Red Flag Rule
**3+ failed fixes = architectural problem, not code bug. Question the design.**

## Pattern 3: Writing Implementation Plans

### Task Structure
```markdown
## Task: [Clear title]

### Prerequisites
- [ ] Read existing code at [path]
- [ ] Check dependencies
- [ ] Understand current behavior

### Implementation (2-5 min tasks)
1. [Task] - File: path/to/file.ext
2. [Task] - Expected output: [specific]
3. [Task] - Verification: [how to test]

### Verification
- [ ] Tests pass
- [ ] Manual verification complete
- [ ] Compliance check (if applicable)
```

### Plan Requirements
- **2-5 minute granular tasks** (not vague multi-hour blocks)
- **Exact file paths** (no ambiguity like "update the config")
- **Complete code samples** (not pseudocode)
- **TDD enforcement built-in** (test tasks before implementation tasks)

## Pattern 4: Subagent-Driven Development

### When to Use
- Clear implementation plan with defined tasks
- Mostly independent tasks
- Need to stay in current session
- Want parallel execution

### Process Per Task
1. **Implementation** - Subagent implements and self-reviews
2. **Spec Review** - Verify code matches requirements exactly
3. **Quality Review** - Ensure quality standards met
4. **Iteration** - Fix issues, reviewers re-check

### Critical Rules
- Fresh subagent per task (no context pollution)
- NEVER skip reviews
- NEVER proceed with unfixed issues
- Spec compliance BEFORE quality review

## Pattern 5: Parallel Agent Dispatching

### When to Use
- 3+ independent failures
- Multiple subsystems broken independently
- Failures must be genuinely unrelated

### Process
1. Identify independent domains
2. Create focused agent prompts
3. Dispatch in parallel
4. Review and integrate results

### Agent Prompt Pattern
**BAD:** "Fix all the tests"
**GOOD:** "Investigate auth failures in tests/auth/*.test.ts. Return root cause and proposed fix. Do not implement yet."

## Pattern 6: Verification Before Completion

### Never Declare Complete Without
- [ ] Tests actually RUNNING and PASSING
- [ ] Manual verification of the fix
- [ ] Compliance checks passing (if applicable)
- [ ] Review stage completed

### Anti-Pattern
"I've implemented the fix" (without verification)

### Correct Pattern
"Fix implemented. Test results: [output]. Compliance check: [results]. Manual verification: [what I checked]."

## Quick Reference

| Situation | Pattern | First Step |
|-----------|---------|------------|
| New feature | TDD | Write failing test |
| Bug report | Systematic Debugging | Read error message thoroughly |
| Complex task | Implementation Plan | Write 2-5 min tasks |
| Multiple failures | Parallel Agents | Identify independent domains |
| Before merge | Code Review | Run full test suite |
