# Wix Velo Code Generator

**Purpose**: Generate production-ready Velo code following Wix best practices

## Capabilities

- Generate Velo code for common patterns
- Follow Wix IDE file structure conventions
- Include proper error handling
- Add SEO metadata management
- Implement CMS data binding

## Usage

When asked to generate Velo code:

1. **Identify the use case** (page code, backend function, CMS binding, etc.)
2. **Follow Wix file structure**:
   - Backend: `src/backend/*.js` or `src/backend/*.web.js`
   - Pages: `src/pages/{PageName}.{ID}.js`
   - Public: `src/public/*.js`
   - Styles: `src/styles/global.css`

3. **Include best practices**:
   - Error handling with try/catch
   - Loading states for async operations
   - SEO metadata via `wix-seo` API
   - Proper import syntax (`backend/`, `public/`)

4. **Add comments** explaining Wix-specific patterns

## Code Patterns

### Backend Web Method
```javascript
import { fetch } from 'wix-fetch';

export async function myWebMethod(param1, param2) {
  try {
    // Implementation
    return { success: true, data: result };
  } catch (error) {
    return { success: false, error: error.message };
  }
}
```

### Page Code with CMS Binding
```javascript
import wixData from 'wix-data';
import { setSEO } from 'wix-seo';

$w.onReady(function () {
  loadPageData();
});

async function loadPageData() {
  try {
    const item = await wixData.get('CollectionName', itemId);
    $w('#text1').text = item.title;
    $w('#richContent1').html = item.content;
    setSEO(item);
  } catch (error) {
    console.error('Error loading data:', error);
  }
}
```

### SEO Metadata
```javascript
import { setSEO } from 'wix-seo';

function setSEO(item) {
  setSEO({
    title: item.seoTitle || item.title,
    description: item.seoDescription || item.description,
    keywords: item.seoKeywords || '',
    openGraph: {
      title: item.title,
      description: item.description,
      image: item.image
    }
  });
}
```

## File Naming Conventions

- **Backend files**: Use descriptive names (e.g., `meztal-sync.js`, `data-hooks.js`)
- **Page files**: Never rename - Wix auto-generates `{PageName}.{ID}.js`
- **Public files**: Use camelCase (e.g., `utils.js`, `seoHelpers.js`)

## Import Rules

- Backend: `import { func } from "backend/fileName";`
- Public: `import { func } from "public/fileName";`
- Never use relative paths (`./`, `../`)

## Error Handling

Always wrap async operations:
```javascript
try {
  const result = await wixData.query('Collection').find();
  // Process result
} catch (error) {
  console.error('Error:', error);
  // Show user-friendly error
}
```
