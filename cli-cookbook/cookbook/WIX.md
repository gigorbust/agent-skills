# Wix CLI Cookbook

## Wix CLI (Local Dev)
```bash
# Install CLI
npm install -g @wix/cli

# Login
wix login

# Create new project
wix create

# Link to existing site
wix link

# Start dev server
wix dev

# Deploy
wix deploy
```

## HTTP Functions Testing
```bash
# Base URL pattern
curl https://www.yoursite.com/_functions/functionName

# GET request
curl -X GET "https://www.yoursite.com/_functions/pages"

# POST with JSON
curl -X POST "https://www.yoursite.com/_functions/sync" \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}'
```

## Wix Data (via HTTP Functions)
```javascript
// In backend/http-functions.js
import { ok, badRequest } from 'wix-http-functions';
import wixData from 'wix-data';

export async function get_pages(request) {
    const results = await wixData.query("Pages").find();
    return ok({ body: JSON.stringify(results.items) });
}
```

## Velo Backend Patterns
```javascript
// backend/module.web.js - callable from frontend
export async function myFunction(param) {
    // Backend logic
    return result;
}

// Frontend call
import { myFunction } from 'backend/module';
const result = await myFunction(param);
```

## Scheduled Jobs
```json
// backend/jobs.config
{
  "jobs": [{
    "functionLocation": "/backend/jobs.jsw",
    "functionName": "dailySync",
    "executionConfig": {
      "cronExpression": "0 0 * * *"
    }
  }]
}
```
