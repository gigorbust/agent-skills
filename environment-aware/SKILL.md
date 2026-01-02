# Skill: Environment Awareness

## Description
Always check what's already installed before attempting installation. Prevents redundant installations and maintains full context of the development environment.

## Trigger
Activate BEFORE any installation command (npm, brew, pip, code --install-extension).

## Pre-Installation Checks

### Global npm Packages
```bash
npm list -g --depth=0 2>/dev/null | grep -i "<package-name>"
```

### VS Code Extensions
```bash
code --list-extensions | grep -i "<extension-id>"
```

### Homebrew Packages (macOS)
```bash
brew list | grep -i "<package-name>"
```

### Python Packages
```bash
pip list | grep -i "<package-name>"
# or
pip show <package-name>
```

### Claude CLI Specifically
```bash
which claude && claude --version
```

## Decision Flow

```
Installation Request
        │
        ▼
┌─────────────────┐
│ Check if exists │
└─────────────────┘
        │
   ┌────┴────┐
EXISTS?      NOT FOUND
   │              │
   ▼              ▼
┌──────────┐ ┌──────────────┐
│ Report:  │ │ Proceed with │
│ Already  │ │ installation │
│ v1.2.3   │ └──────────────┘
└──────────┘
```

## Response Pattern

**If already installed:**
> ✅ `<package>` is already installed (version X.Y.Z). No action needed.

**If not installed:**
> Installing `<package>`...

## Anti-Patterns

❌ **Never** assume installation state without checking
❌ **Never** suggest "might be installed" — verify
❌ **Never** skip version reporting for existing installs
