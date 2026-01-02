# MezTal Wix Orchestrator

## Purpose
Domain-specific orchestrator for all Wix CMS, Velo, and site operations. Handles the complexity of Wix platform interactions.

## Trigger
Detected by `intelligent-router` when request contains: "wix", "cms", "velo", "collection", "page", "site"

## Pre-Flight Checks
Before ANY Wix operation:
```
1. Confirm Site ID: 24c6a184-1fd5-4b8c-ade1-8f2dae9c8f9e
2. Check WixREADME for current docs
3. Verify wix-mcp availability (environment-specific)
4. Load CMS_URL_ARCHITECTURE.json
```

## Operation Categories

### CMS Operations
```
Collection CRUD:
→ Check existing schema first
→ Validate field types
→ Handle references properly
→ Update architecture docs
```

### Page Operations
```
Create/Edit pages:
→ Use Wix Studio (editor.wix.com)
→ Follow responsive design patterns
→ Apply SEO settings inline
→ Test mobile view
```

### Velo Code
```
Backend/Frontend code:
→ Prefer Wix CLI over IDE automation
→ Manual steps documented in WIX_TEMPLATE_FIX_STEPS.md
→ Test in sandbox before production
```

### Publishing
```
CRITICAL - NEVER publish without explicit approval
→ Document all changes first
→ User must confirm
→ Sandbox testing required
```

## Environment-Specific Routing

| Environment | MCP Available | Fallback |
|-------------|---------------|----------|
| Claude Code | Filesystem-based | Wix CLI commands |
| Antigravity | None yet | Browser automation, CLI |
| Cursor | wix-mcp possible | Direct MCP calls |

## Known Limitations
- Browser automation blocked by cross-origin (Google API rate limits)
- IDE automation unreliable
- Manual steps often required for Velo changes

## Skills Invoked
| Skill | When |
|-------|------|
| `systematic-debugging` | Velo errors |
| `web-developer` | Frontend components |
| `git-wizard` | Wix CLI repo sync |

## Integration
- **Called by**: `intelligent-router`
- **Uses**: wix-mcp (when available), Wix CLI, browser tools
- **References**: WIX_TEMPLATE_FIX_STEPS.md, CMS_URL_ARCHITECTURE.json
