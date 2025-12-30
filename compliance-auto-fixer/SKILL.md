---
name: compliance-auto-fixer
description: Automatically detects and fixes MezTal compliance violations in content files. Use when checking content for banned phrases, wrong percentages, or missing location mentions.
---

# Compliance Auto-Fixer

## Purpose
Self-healing tool that scans content files and automatically corrects compliance violations.

## Violations Detected & Fixed

### 1. Cost Savings Percentage
**Banned:** 50%, 48%, "half the cost", "50 percent"
**Required:** "approximately 40% cost savings"

### 2. Location Mentions
**Required:** Both Guadalajara AND Mexico City must appear
**Fix:** Add "with offices in Guadalajara and Mexico City" if missing

### 3. Forbidden Content
- ❌ Specific salary figures → Remove
- ❌ Timeline promises ("within 2 weeks") → Replace with "rapid"
- ❌ Competitor names → Remove

## Usage

### Quick Scan (Report Only)
```bash
# Find violations without fixing
grep -rn "50%" ~/Desktop/Meztal/content/ 
grep -rn "48%" ~/Desktop/Meztal/content/
grep -rL "Guadalajara" ~/Desktop/Meztal/content/ | xargs grep -L "Mexico City"
```

### Auto-Fix Command
```bash
# Fix percentage violations
find ~/Desktop/Meztal/content/ -name "*.md" -exec sed -i '' \
  -e 's/50% cost savings/approximately 40% cost savings/g' \
  -e 's/48% cost savings/approximately 40% cost savings/g' \
  -e 's/half the cost/approximately 40% cost savings/g' {} \;
```

### Validation Report
After running auto-fix, generate compliance report:
```bash
echo "=== COMPLIANCE AUDIT ===" 
echo "Files with 50%:" && grep -rn "50%" ~/Desktop/Meztal/content/ | wc -l
echo "Files with 48%:" && grep -rn "48%" ~/Desktop/Meztal/content/ | wc -l
echo "Files missing Guadalajara:" && grep -rL "Guadalajara" ~/Desktop/Meztal/content/ | wc -l
echo "Files missing Mexico City:" && grep -rL "Mexico City" ~/Desktop/Meztal/content/ | wc -l
```

## Integration Points
- Run after ANY content generation
- Add to PostToolUse hook for Write/Edit operations
- Include in CI/CD pipeline before deployment
