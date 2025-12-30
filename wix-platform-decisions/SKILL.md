---
name: wix-platform-decisions
description: Use when deciding between Wix development approaches - Velo vs SDK, Editor vs Headless, Studio vs CLI. Provides decision matrices and trade-off analysis for Wix platform choices.
---

# Wix Platform Decisions

## Overview

Decision framework for choosing between Wix development approaches based on project needs.

## Decision Matrix: Velo vs JavaScript SDK

| Factor | Velo API | JavaScript SDK |
|:-------|:---------|:---------------|
| **Status** | Legacy (maintained) | Future (active dev) |
| **Best For** | In-editor sites | Headless/external apps |
| **Learning Curve** | Lower | Higher |
| **Flexibility** | Limited | Full control |
| **SEO Control** | Good | Excellent |
| **Performance** | Wix-managed | You control |
| **Deployment** | Wix hosting | Vercel/Netlify/any |

### Choose Velo When:
- ✅ Site lives in Wix Editor/Studio
- ✅ Using Wix visual builder heavily
- ✅ Fast iteration needed
- ✅ Team familiar with Wix ecosystem
- ✅ SEO control is sufficient

### Choose SDK/Headless When:
- ✅ Maximum performance needed
- ✅ Full code control required
- ✅ Custom hosting preferred
- ✅ Advanced SEO requirements
- ✅ Team prefers React/Next.js

## Decision Matrix: Wix Studio vs Wix CLI

| Factor | Wix Studio (Visual) | Wix CLI (Code-first) |
|:-------|:--------------------|:---------------------|
| **Workflow** | Visual editing | Local development |
| **Git Integration** | Limited | Full |
| **Team Collaboration** | Visual sharing | Code review |
| **Custom Components** | Wix Blocks | Any framework |
| **Debugging** | Wix Console | Local dev tools |

## MezTal Recommendation

### Current State (Optimal)
```
Wix Studio + Velo API
├── Fast iteration
├── Visual editing for non-devs
├── CMS sync via backend modules
└── Sufficient SEO control
```

### Future Upgrade Path (When Needed)
```
Wix Headless + Next.js + SDK
├── Maximum performance
├── Full SEO control via SSR/SSG
├── Vercel deployment
└── Modern React patterns
```

### Migration Trigger Criteria
Migrate to Headless when ANY of these apply:
- [ ] Core Web Vitals failing consistently
- [ ] Complex routing needs beyond router.js
- [ ] Need server-side rendering for SEO
- [ ] Team outgrowing visual editor
- [ ] Custom caching requirements

## Quick Reference

### For New MezTal Features
1. **Simple page content** → Wix Studio visual
2. **Backend logic** → Velo backend modules (.web.js)
3. **External integrations** → HTTP Functions
4. **Scheduled tasks** → jobs.config
5. **Complex forms** → Consider SDK migration

### SDK Quick Start (Future)
```bash
npm install @wix/sdk @wix/data @wix/members
```

```javascript
import { createClient } from '@wix/sdk';
import { items } from '@wix/data';

const client = createClient({
  auth: OAuthStrategy({ clientId: 'YOUR_ID' })
});

const result = await client.items.queryItems({
  dataCollectionId: 'Pages'
}).find();
```
