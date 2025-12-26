---
name: git-wizard
description: Expert Git operations handler. specializes in complex recovery, LFS management, and safe history rewriting. Use for "fix git", "undo commit", "clean rebase", "fix detached head", "normalize LFS".
allowed-tools: Bash, Git, Grep, Read
---

# Git Wizard Skill

## Purpose
To perform complex or risky Git operations safely, with a focus on data integrity and "Sync Procedure" compliance (Git LFS).

## Capabilities

### 1. Safe Rebase
**Trigger:** "Safe rebase", "Update from main"
**Protocol:**
1.  **Check Status**: Ensure working tree is clean.
2.  **Backup**: Create a temp branch `backup/pre-rebase-[timestamp]`.
3.  **Fetch**: `git fetch origin`.
4.  **Rebase**: `git rebase origin/main`.
5.  **Conflict Handling**: If conflicts arise, STOP and list them. Do not auto-resolve deletion conflicts without checking `deletion_log.txt`.

### 2. Git LFS Normalization
**Trigger:** "Normalize LFS", "Fix pointers"
**Context:** When large files show as modified text files instead of pointers.
**Command Sequence:**
```bash
git add --renormalize .
git status # Verify they are staged as pointer updates
git commit -m "chore: Normalize Git LFS pointers"
```

### 3. Detached HEAD Recovery
**Trigger:** "Fix detached head", "Save my work"
**Protocol:**
1.  **Identify State**: `git log -1`.
2.  **Create Branch**: `git branch temp-recovery-[timestamp]`.
3.  ** Checkout**: `git checkout temp-recovery-[timestamp]`.
4.  **Merge/Rebase**: Guide user to merge this back into their target branch.

## Safety Rules
*   **NEVER** `git push --force` without explicit confirmation and backup.
*   **ALWAYS** check `git status` before running commands.
*   **LFS Awareness**: Always check if `.gitattributes` exists before adding binary files.
