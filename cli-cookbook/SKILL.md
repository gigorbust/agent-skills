---
name: cli-cookbook
description: Use when needing quick reference for CLI commands, terminal patterns, or common operations. Provides instant access to frequently used commands for git, npm, wix, brew, and project-specific tools. Organized by domain for progressive disclosure.
---

# CLI Cookbook

Quick reference for common CLI patterns. Read only the section you need.

## Quick Navigation

- **Git**: See [GIT.md](cookbook/GIT.md)
- **npm/Node**: See [NPM.md](cookbook/NPM.md)
- **Wix CLI**: See [WIX.md](cookbook/WIX.md)
- **macOS**: See [MACOS.md](cookbook/MACOS.md)
- **Python**: See [PYTHON.md](cookbook/PYTHON.md)

## Essential One-Liners

### Git Status Check
```bash
git status && git log --oneline -5
```

### Quick Commit
```bash
git add -A && git commit -m "message"
```

### Kill Port
```bash
lsof -ti:3000 | xargs kill -9
```

### Find Large Files
```bash
find . -type f -size +100M
```

### Watch File Changes
```bash
fswatch -o . | xargs -n1 -I{} echo "Changed"
```

## Domain-Specific

For detailed commands, read the relevant cookbook file.
