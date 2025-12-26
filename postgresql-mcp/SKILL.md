---
name: postgresql-mcp
description: PostgreSQL database access via MCP server. Use when working with Postgres databases, running SQL queries, exploring schemas, or analyzing database relationships. Enables natural language database interaction.
---

# PostgreSQL MCP Server Skill

## When to Use
- Querying PostgreSQL databases
- Exploring database schemas
- Finding table relationships
- Running SQL queries through Claude
- Database migrations with Neon

## Installation

### Basic PostgreSQL MCP
```bash
# Add to project
claude mcp add -s project db-name npx -- -y @modelcontextprotocol/server-postgres postgresql://user:pass@host/dbname

# Add globally (user scope)
claude mcp add -s user my-db npx -- -y @modelcontextprotocol/server-postgres postgresql://localhost/mydb
```

### Neon MCP Server
For Neon Postgres with natural language migrations:
```bash
claude mcp add neon-mcp npx -- -y @neondatabase/mcp-server-neon
```

### Postgres MCP Pro
Advanced features (index tuning, explain plans, health checks):
```bash
# Set connection URI
export DATABASE_URL="postgresql://user:pass@host/db"
npx -y postgres-mcp-pro
```

## Capabilities

### Database Querying
Execute SQL queries directly through Claude:
```
"Show me all users who signed up in the last week"
"Find orders with status 'pending' and total > 100"
```

### Schema Exploration
```
"List all tables in this database"
"Describe the users table"
"Show me the columns in the orders table"
```

### Relationship Discovery
```
"What tables reference the users table?"
"Find relationships between orders and products"
"Show me the foreign keys in this schema"
```

### Read-Only Mode
For safety, use read-only access:
```bash
# Read-only MCP server
claude mcp add -s project readonly-db npx -- -y @modelcontextprotocol/server-postgres postgresql://user:pass@host/db?readonly=true
```

## Security Considerations

1. **Use read-only credentials** when possible
2. **Never commit connection strings** to git
3. **Use environment variables** for credentials:
   ```bash
   export DATABASE_URL="postgresql://..."
   ```
4. **Restrict to specific schemas** when available

## Common Patterns

### Exploring Unknown Database
```
1. "List all tables"
2. "Describe each table"
3. "Find relationships between tables"
4. "Show sample data from key tables"
```

### Debugging Data Issues
```
1. "Find orphaned records in orders"
2. "Show duplicates in users table"
3. "Check referential integrity"
```

### Schema Documentation
```
1. "Generate ERD description"
2. "Document all foreign keys"
3. "List indexes on each table"
```

## Troubleshooting

### Connection Failed
- Check connection string format
- Verify credentials
- Ensure database is accessible from your network
- Check if SSL is required

### Permission Denied
- Verify user has SELECT permission
- Check schema access grants
- Try read-only connection string

### MCP Server Not Loading
```bash
# Check MCP status
claude mcp list

# View server logs
claude --debug
```

## Sources
- [PostgreSQL MCP Server](https://www.claudemcp.com/servers/postgres)
- [Neon MCP Guide](https://neon.com/guides/claude-code-mcp-neon)
- [MCP Toolbox for Databases](https://googleapis.github.io/genai-toolbox/how-to/connect-ide/postgres_mcp/)
