---
name: worktree-manager
description: Comprehensive git worktree management - list, create, remove, and switch between worktrees. Use when managing parallel development branches, when needing isolated workspaces, or when cleaning up completed feature branches. Extends basic worktree operations with full lifecycle management.
---

# Worktree Manager Skill

## Overview

Manages the complete lifecycle of git worktrees - isolated workspaces that share the same repository. Goes beyond single operations to provide full management capabilities.

**Announce at start:** "I'm using the worktree-manager skill to manage isolated workspaces."

## Core Operations

### List Worktrees

```bash
# List all worktrees with status
git worktree list
```

**Output interpretation:**
- Main worktree: Primary checkout location
- Feature worktrees: Isolated branches for parallel work

### Create Worktree

**Prerequisites:**
1. Check if worktree directory is gitignored (for project-local)
2. Verify branch doesn't already exist

```bash
# Create with new branch
git worktree add .worktrees/<feature-name> -b <branch-name>

# Create from existing branch
git worktree add .worktrees/<feature-name> <existing-branch>
```

### Remove Worktree

```bash
# Standard removal
git worktree remove .worktrees/<feature-name>

# Force removal (uncommitted changes)
git worktree remove --force .worktrees/<feature-name>

# Cleanup stale references
git worktree prune
```

### Switch Context

To work in a worktree:
1. Navigate: `cd .worktrees/<feature-name>`
2. Verify: `git branch` shows correct branch
3. Work normally (all git commands work)

## Directory Strategy

| Location | Use Case |
|:---------|:---------|
| `.worktrees/` | Project-local, gitignored |
| `~/.claude-worktrees/<project>/` | Global, Claude Code managed |
| `~/.config/superpowers/worktrees/` | User preference location |

## Complete Workflow

### Starting Feature Work

1. List existing: `git worktree list`
2. Create new: `git worktree add .worktrees/feature-x -b feature/x`
3. Navigate: `cd .worktrees/feature-x`
4. Install deps: `npm install` / `pip install -r requirements.txt`
5. Verify tests pass
6. Begin work

### Completing Feature Work

1. Commit all changes
2. Push branch
3. Create PR (if applicable)
4. Merge (when approved)
5. Navigate back: `cd /path/to/main`
6. Remove worktree: `git worktree remove .worktrees/feature-x`
7. Delete branch: `git branch -d feature/x`
8. Prune: `git worktree prune`

## Integration

**Uses:**
- `using-git-worktrees` - For detailed creation guidance
- `finishing-a-development-branch` - For cleanup

**Pairs with:**
- `fork-terminal` - Fork to worktree context
- `subagent-driven-development` - Parallel worktree work

## Quick Reference

| Task | Command |
|:-----|:--------|
| List all | `git worktree list` |
| Create | `git worktree add <path> -b <branch>` |
| Remove | `git worktree remove <path>` |
| Prune stale | `git worktree prune` |
| Lock (protect) | `git worktree lock <path>` |
| Unlock | `git worktree unlock <path>` |

## Red Flags

**Never:**
- Create worktree without verifying gitignore
- Remove worktree with uncommitted work (without --force and intent)
- Forget to run deps install in new worktree

**Always:**
- Verify tests pass in new worktree before work
- Complete full cleanup after merge
- Use consistent naming (feature/*, fix/*, etc.)
