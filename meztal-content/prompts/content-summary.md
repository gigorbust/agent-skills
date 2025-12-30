# Content Summary Prompt

Use this template when forking context or handing off content work.

## Summary Template

```yaml
content_status:
  type: [pillar|spoke|comparison|blog|case-study]
  keyword: "[primary keyword]"
  target_url: "/[url-path]/"
  word_count_target: [number]
  word_count_current: [number]
  
sections_completed:
  - title: "[Section name]"
    status: complete|in_progress|not_started
  - title: "[Section name]"
    status: complete|in_progress|not_started

compliance_status:
  cost_savings_mentioned: true|false
  locations_mentioned: true|false
  no_salary_figures: true|false
  no_timeline_promises: true|false
  no_competitor_names: true|false

internal_links_added:
  - "[Link text]" → "/[target-url]/"
  - "[Link text]" → "/[target-url]/"

next_actions:
  - "[Specific next task]"
  - "[Specific next task]"

related_files:
  - "[File that needs updating]"
  - "[Registry entry to add]"
```

## Usage

When forking to new session:
1. Fill out this template with current state
2. Pass to new agent as context
3. New agent continues from documented state

When completing content:
1. Fill out final state
2. Include in commit message
3. Add to MASTER_REGISTRY.json
