---
name: backup-watchdog
description: Self-healing tool that ensures all work is committed to git at regular intervals or before context exhaustion. Prevents data loss from crashes or context window limits.
---

# Backup Watchdog

## Purpose
Automatically commits and pushes work to prevent data loss from:
- Context window exhaustion
- Session crashes
- Network disconnections
- Accidental terminal closure

## Triggers

### 1. Time-Based (Every 30 mins)
Reminder to run backup if significant work is uncommitted.

### 2. Pre-Compact (Automatic)
Hook fires before `/compact` to save work.

### 3. Context Warning (80% usage)
When context window approaches limit, auto-commit.

### 4. Session End
Always commit before closing session.

## Backup Commands

### Quick Backup
```bash
cd ~/Desktop/Meztal && \
git add -A && \
git commit -m "[AUTO-BACKUP] $(date +%Y-%m-%d_%H%M) - Watchdog save" && \
git push origin main
```

### Status Check
```bash
cd ~/Desktop/Meztal && git status --short
```

### Force Push (if rejected)
```bash
git pull --rebase && git push origin main
```

## Hook Configuration

Add to `~/.claude/settings.json`:
```json
{
  "hooks": {
    "PreCompact": [{
      "hooks": [{
        "type": "command",
        "command": "cd $CLAUDE_PROJECT_DIR && git add -A && git diff --cached --quiet || git commit -m '[COMPACT-BACKUP] Context save'"
      }]
    }],
    "SessionEnd": [{
      "hooks": [{
        "type": "command", 
        "command": "cd $CLAUDE_PROJECT_DIR && git add -A && git commit -m '[SESSION-END] Auto-backup' && git push"
      }]
    }]
  }
}
```

## Watchdog Protocol

```
[30 min timer or context > 80%]
         ↓
[Check: git status --porcelain]
         ↓
    Has changes?
     /       \
   Yes        No
    ↓          ↓
[Commit]    [Skip]
    ↓
[Push to remote]
    ↓
[Log: "Backup complete at HH:MM"]
```

## Recovery from Lost Work

If work was lost (rare):
```bash
# Check reflog for recent commits
git reflog show --all | head -20

# Recover specific commit
git checkout <commit-hash> -- path/to/file
```

## Integration with Skills Directory

The backup watchdog also commits changes to `~/.claude/skills/`:
```bash
cd ~/.claude/skills && \
git add -A && \
git commit -m "[SKILLS-BACKUP] $(date +%Y-%m-%d)" && \
git push origin main
```
