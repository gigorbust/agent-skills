---
name: wix-cms-direct
description: Use when performing direct Wix CMS operations - querying collections, inserting items, updating data, bulk operations. Triggers on "query cms", "insert item", "update collection", "bulk upload", "sync to wix", "cms operations", "wix data". Requires wix-data MCP.
---

# Wix CMS Direct Operations Skill

**Purpose**: Direct CMS read/write without manual IDE work

## Pre-Flight (MANDATORY)

Before ANY CMS operation:
1. Call `WixREADME` (wix-mcp tool) - ALWAYS FIRST
2. Verify Site ID: `24c6a184-1fd5-4b8c-ade1-8f2dae9c8f9e`
3. Check collection exists: `list_collections` (wix-data MCP)

## Variables

```
SANDBOX_SITE_ID: 792fe01d-fa28-4833-b811-b5a540f5568b
PRODUCTION_SITE_ID: 24c6a184-1fd5-4b8c-ade1-8f2dae9c8f9e
PROJECT_PATH: /Users/georgegayl/Desktop/Meztal
```

## Operations

### Query Items
```
Tool: mcp__wix-data__query_items
Params:
  collectionId: "collection-name"
  filter: { "fieldName": "value" }  # Optional
  limit: 50  # Default
  skip: 0    # For pagination
```

### Insert Single Item
```
Tool: mcp__wix-data__insert_item
Params:
  collectionId: "collection-name"
  item: { "field1": "value1", "field2": "value2" }
  confirm: true  # REQUIRED for safety
```

### Update Item
```
Tool: mcp__wix-data__update_item
Params:
  collectionId: "collection-name"
  itemId: "item-id"
  item: { "field1": "updated-value" }
  confirm: true  # REQUIRED
```

### Bulk Insert
```
Tool: mcp__wix-data__bulk_insert
Params:
  collectionId: "collection-name"
  items: [{ ... }, { ... }]
  confirm: true  # REQUIRED
```

### Delete Item
```
Tool: mcp__wix-data__delete_item
Params:
  collectionId: "collection-name"
  itemId: "item-id"
  confirm: true  # REQUIRED - IRREVERSIBLE
```

## Workflow: Content → CMS Sync

```
1. VERIFY
   ├── Call WixREADME
   ├── Get collection schema
   └── Validate content matches schema

2. PREPARE
   ├── Read content file
   ├── Map to CMS fields
   └── Generate item object

3. EXECUTE
   ├── Insert/update item
   ├── Capture item ID
   └── Update MASTER_REGISTRY.json

4. VALIDATE
   ├── Query to verify
   └── Report success/failure
```

## Collection Schemas (MezTal)

### Services Collection
```json
{
  "title": "string",
  "slug": "string",
  "description": "richText",
  "heroImage": "image",
  "seoTitle": "string",
  "seoDescription": "string",
  "category": "reference"
}
```

### Blog Collection
```json
{
  "title": "string",
  "slug": "string",
  "content": "richText",
  "excerpt": "string",
  "publishDate": "datetime",
  "author": "reference",
  "tags": "array"
}
```

## Error Handling

| Error | Cause | Fix |
|-------|-------|-----|
| `WDE0110` | Wix Code not enabled | Install Wix Code app |
| `404` | Collection not found | Verify collection ID |
| `400` | Invalid field | Check schema |
| `401` | Auth failed | Re-authenticate |

## Safety Rules

- ✅ Always use `confirm: true`
- ✅ Test on SANDBOX first
- ❌ NEVER delete without explicit approval
- ❌ NEVER bulk update production without backup

## Integration

**Uses MCP**:
- `wix-data` - All CRUD operations
- `wix-mcp` - Documentation, WixREADME

**Called By**:
- `meztal-content-orchestrator` agent
- `meztal-wix-orchestrator` agent
- `/sync-to-cms` command
