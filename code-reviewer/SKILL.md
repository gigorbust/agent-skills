---
name: code-reviewer
description: Read-only code review for safety, performance, and quality issues. Use when reviewing code, checking PRs, analyzing code quality, or auditing security. Cannot modify files - analysis only. Triggers on terms like "review this code", "code review", "check this PR", "audit", "security review", "code quality".
allowed-tools: Read, Grep, Glob
---

# Code Reviewer Skill (Read-Only)

## Version History
- v2.0.0 (2025-12-25): Expanded checklist, added output format, trigger terms
- v1.0.0 (2025-12-25): Initial release

## Purpose
Analyze code for issues WITHOUT making changes. This skill is intentionally restricted to read-only tools for safety.

## Review Checklist

### 1. Safety & Security
- [ ] No hardcoded credentials or secrets
- [ ] Input validation present
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] CSRF protection where needed
- [ ] Proper authentication/authorization checks
- [ ] Sensitive data handling

### 2. Performance
- [ ] No N+1 queries
- [ ] Appropriate caching
- [ ] No unnecessary loops or O(n²) algorithms
- [ ] Efficient data structures
- [ ] Lazy loading where appropriate
- [ ] No memory leaks

### 3. Code Quality
- [ ] Clear naming conventions
- [ ] Single responsibility principle
- [ ] DRY (no duplicated logic)
- [ ] Appropriate error handling
- [ ] Adequate test coverage
- [ ] No dead code

### 4. Architecture
- [ ] Proper separation of concerns
- [ ] Dependency injection where appropriate
- [ ] Interface usage
- [ ] Appropriate abstraction level

## Output Format

```markdown
## Code Review: [file/component name]

### Summary
[1-2 sentence overview]

### Critical Issues (Must Fix)
1. [Issue] - Line X - [Explanation]

### Warnings (Should Fix)
1. [Issue] - Line X - [Explanation]

### Suggestions (Nice to Have)
1. [Suggestion] - Line X - [Explanation]

### Positive Observations
- [What's done well]
```

## Instructions
1. Read the target files using `Read` tool
2. Search for patterns using `Grep` (secrets, TODO, FIXME, etc.)
3. Find related files using `Glob`
4. Apply checklist systematically
5. Provide detailed feedback using output format

## Usage Examples

**Review a file:**
"Review src/auth/login.ts for security issues"

**Review a PR:**
"Do a code review of the changes in this PR"

**Audit for specific concerns:**
"Check this code for SQL injection vulnerabilities"

## Limitations
This skill CANNOT modify files. It can only:
- Read files (Read tool)
- Search for patterns (Grep tool)
- Find files (Glob tool)

To make changes based on review findings, use a separate editing operation.
