---
name: mcp-mastery
description: Use when working with Model Context Protocol (MCP) servers, building MCP clients, debugging MCP connections, or integrating external tools via MCP. Provides complete understanding of MCP architecture, primitives, and implementation patterns.
---

# MCP Mastery

## Overview

Model Context Protocol (MCP) is the standard for connecting AI systems with external tools and data sources. This skill provides comprehensive MCP knowledge.

## Architecture

```
┌─────────────────────────────────────────────┐
│              MCP HOST                       │
│  (Claude Code, Antigravity, Claude Desktop) │
└───────────────┬─────────────────────────────┘
                │ manages
        ┌───────┴───────┐
        ▼               ▼
┌───────────────┐ ┌───────────────┐
│  MCP CLIENT   │ │  MCP CLIENT   │
│  (connection) │ │  (connection) │
└───────┬───────┘ └───────┬───────┘
        │                 │
        ▼                 ▼
┌───────────────┐ ┌───────────────┐
│  MCP SERVER   │ │  MCP SERVER   │
│  (GitKraken)  │ │  (Netlify)    │
└───────────────┘ └───────────────┘
```

## Core Concepts

### Participants
| Role | Description | Examples |
|:-----|:------------|:---------|
| **Host** | AI app managing clients | Claude Code, Antigravity |
| **Client** | Connection to a server | One per server |
| **Server** | Provides context/tools | GitKraken, Netlify, Notion |

### Layers
| Layer | Protocol | Purpose |
|:------|:---------|:--------|
| **Data** | JSON-RPC 2.0 | Communication format |
| **Transport** | stdio or HTTP | Message delivery |

### Primitives (What Servers Provide)
| Primitive | Purpose | Methods |
|:----------|:--------|:--------|
| **Tools** | Executable functions | `tools/list`, `tools/call` |
| **Resources** | Data sources | `resources/list`, `resources/read` |
| **Prompts** | Interaction templates | `prompts/list`, `prompts/get` |

## Transport Types

### Stdio (Local)
- Direct process communication
- No network overhead
- Optimal for local servers

### HTTP (Remote)
- POST for client→server
- Server-Sent Events for streaming
- OAuth for authentication

## Our Active MCP Servers

| Server | Purpose | Primitives Used |
|:-------|:--------|:----------------|
| **GitKraken** | Git operations | Tools (status, commit, push) |
| **Netlify** | Deployment | Tools (deploy, projects) |
| **Notion** | Documentation | Resources + Tools |
| **Sequential-Thinking** | Reasoning | Tools (think, plan) |

## Using MCP CLI

```bash
# Location
~/.npm-global/bin/mcp

# Inspect server
mcp inspect <server-name>

# List available servers
mcp list
```

## Building MCP Servers

### SDKs Available
- TypeScript/JavaScript: `@modelcontextprotocol/sdk`
- Python: `mcp`
- Other languages via spec implementation

### Basic Server Structure
```typescript
import { Server } from "@modelcontextprotocol/sdk/server";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio";

const server = new Server({
  name: "my-server",
  version: "1.0.0"
}, {
  capabilities: {
    tools: {}
  }
});

// Define tools
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return { tools: [/* ... */] };
});

// Start
const transport = new StdioServerTransport();
await server.connect(transport);
```

## Debugging MCP

### MCP Inspector
```bash
npx @modelcontextprotocol/inspector
```
Opens browser UI for testing servers.

### Common Issues
| Issue | Solution |
|:------|:---------|
| Server not found | Check path in config |
| Auth failure | Verify API keys |
| Connection timeout | Check stdio vs HTTP |
| Tools not appearing | Restart host app |

## Configuration

### Claude Code Settings
```json
// ~/.claude/settings.json or project .claude/settings.json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@my-server/package"]
    }
  }
}
```

## Key Resources

- Spec: https://modelcontextprotocol.io/specification/latest
- SDKs: https://modelcontextprotocol.io/docs/sdk
- Inspector: https://github.com/modelcontextprotocol/inspector
- Reference Servers: https://github.com/modelcontextprotocol/servers
