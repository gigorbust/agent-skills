# Git Cookbook

## Worktrees
```bash
# List all
git worktree list

# Create with new branch
git worktree add .worktrees/<name> -b <branch>

# Remove
git worktree remove .worktrees/<name>

# Prune stale
git worktree prune
```

## Branches
```bash
# Create and switch
git checkout -b feature/name

# Delete local
git branch -d branch-name

# Delete remote
git push origin --delete branch-name

# List all (local + remote)
git branch -a
```

## Stash
```bash
# Stash with message
git stash push -m "message"

# List stashes
git stash list

# Apply specific
git stash apply stash@{0}

# Pop and remove
git stash pop
```

## Undo
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Discard file changes
git checkout -- <file>

# Unstage file
git reset HEAD <file>
```

## Logs
```bash
# Compact log
git log --oneline -10

# Graph view
git log --graph --oneline --all

# File history
git log --follow -p -- <file>

# Search commits
git log --grep="keyword"
```

## Diff
```bash
# Staged changes
git diff --staged

# Between branches
git diff main..feature

# Specific file
git diff HEAD -- <file>
```

## Remote
```bash
# Show remotes
git remote -v

# Fetch all
git fetch --all

# Push with tracking
git push -u origin <branch>
```
