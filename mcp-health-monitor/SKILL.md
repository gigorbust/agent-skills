---
name: mcp-health-monitor
description: Self-healing tool that monitors MCP server connections and auto-reconnects on failure. Use at session start or when MCP tools fail unexpectedly.
---

# MCP Health Monitor

## Purpose
Ensures all configured MCP servers remain connected and functional. Auto-restarts dead connections.

## Monitored MCP Servers

| Server | Check Method | Recovery Action |
|--------|--------------|-----------------|
| GitKraken | `git_status` call | Restart via settings |
| Netlify | List projects | Restart via settings |
| Notion | List databases | Re-authenticate |
| sequential-thinking | Tool ping | Restart |
| wix-mcp | Site query | Check API key |
| ga4-mcp | Property query | Check credentials |

## Health Check Script

### Quick Check (Run at session start)
```bash
# Check which MCPs are responding
echo "=== MCP HEALTH CHECK ===" 
echo "Checking GitKraken..." && timeout 5 claude -p "git status" 2>/dev/null && echo "✅ GitKraken OK" || echo "❌ GitKraken DEAD"
echo "Checking Notion..." && timeout 5 claude -p "list notion databases" 2>/dev/null && echo "✅ Notion OK" || echo "❌ Notion DEAD"
```

### In-Session Check
Use `/mcp` command to see active connections.

## Recovery Procedures

### 1. MCP Server Not Responding
```bash
# View current MCP config
cat ~/.claude/settings.local.json | jq '.mcpServers'

# Restart Claude Code to reload MCPs
# Or use: /mcp reconnect <server-name>
```

### 2. Authentication Expired
```bash
# Re-authenticate specific MCP
mcp add-from-claude-desktop  # For desktop-authenticated MCPs
```

### 3. Server Process Crashed
```bash
# Check if MCP process is running
ps aux | grep mcp

# Restart specific server
npm exec -- mcp-server-<name>
```

## Auto-Heal Hook Integration

Add to `~/.claude/settings.json`:
```json
{
  "hooks": {
    "SessionStart": [{
      "hooks": [{
        "type": "command",
        "command": "echo 'MCP Health Check Starting...' && /mcp"
      }]
    }]
  }
}
```

## Alert Conditions
- MCP timeout > 5 seconds → Restart
- 3 consecutive failures → Alert user
- Authentication error → Prompt re-auth
