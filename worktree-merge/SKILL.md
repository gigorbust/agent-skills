---
name: worktree-merge
description: Intelligent merge for git worktrees - conflict detection, resolution strategies, and clean merge workflows. Use after completing feature work in a worktree.
---

# Worktree Merge Skill

## Overview

Smart merge workflow for worktrees with conflict prevention and resolution.

**Announce:** "Using worktree-merge skill for intelligent merge."

## Pre-Merge Checklist

### 1. Verify Work Complete
```bash
cd .worktrees/<feature>
git status  # Must be clean
git log --oneline -5  # Review commits
```

### 2. Sync with Main
```bash
# Fetch latest
git fetch origin main

# Check divergence
git log --oneline HEAD..origin/main  # Commits you're missing
git log --oneline origin/main..HEAD  # Your new commits
```

### 3. Conflict Detection
```bash
# Dry-run merge to detect conflicts
git merge-tree $(git merge-base HEAD origin/main) HEAD origin/main
```

If conflicts detected → Go to Resolution section.

## Merge Strategies

### Strategy 1: Rebase (Preferred)
**When:** Linear history preferred, few commits
```bash
git rebase origin/main
# Resolve conflicts if any
git push --force-with-lease
```

### Strategy 2: Merge Commit
**When:** Preserving branch history, many commits
```bash
git merge origin/main
# Resolve conflicts if any
git push
```

### Strategy 3: Squash
**When:** Many small commits, want single commit
```bash
git rebase -i origin/main
# Mark commits as 'squash' except first
git push --force-with-lease
```

## Conflict Resolution

### File-Level Strategy
| File Type | Strategy |
|:----------|:---------|
| Code (.js, .py) | Manual review required |
| Config (.json) | Often take theirs + add ours |
| Docs (.md) | Usually merge both |
| Generated | Regenerate after merge |

### Resolution Commands
```bash
# Accept theirs
git checkout --theirs <file>

# Accept ours  
git checkout --ours <file>

# Manual edit then mark resolved
git add <file>

# Continue merge/rebase
git merge --continue
# or
git rebase --continue
```

## Post-Merge Cleanup

### 1. Verify Build
```bash
npm install && npm test
# or project-appropriate command
```

### 2. Return to Main
```bash
cd /path/to/main
git pull
```

### 3. Remove Worktree
```bash
git worktree remove .worktrees/<feature>
git branch -d feature/<name>
git worktree prune
```

## Quick Reference

| Step | Command |
|:-----|:--------|
| Check conflicts first | `git merge-tree ...` |
| Rebase | `git rebase origin/main` |
| Merge | `git merge origin/main` |
| Take theirs | `git checkout --theirs <file>` |
| Take ours | `git checkout --ours <file>` |
| Continue | `git rebase --continue` |
| Cleanup | `git worktree remove <path>` |

## Integration

**Follows:** `worktree-manager`, `using-git-worktrees`
**Before:** `finishing-a-development-branch`
