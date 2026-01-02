# Agentic Research Skill

## Purpose
Execute structured research with mandatory self-critique. Implements the 6-step task decomposition pattern for any research, analysis, or content synthesis task.

## Trigger
Detected by `context-orchestrator` when request contains:
- "research", "analyze", "investigate", "compare"
- "find out", "what is", "how does"
- "synthesize", "summarize sources"

## Protocol

### Step 1: OUTLINE
Structure the research question:
```
- What is the core question?
- What sub-questions need answering?
- What would a complete answer include?
- What sources would be authoritative?
```

### Step 2: SEARCH
Generate optimal search queries:
```
1. Generate 3-5 targeted search terms
2. Include: technical terms, alternatives, related concepts
3. Avoid: vague terms, overly broad queries
```
**Tool**: `search_web`

### Step 3: FETCH
Retrieve and parse sources:
```
1. Use search results to identify best URLs
2. Fetch 3-5 high-quality sources
3. Extract key information from each
4. Note source credibility
```
**Tools**: `read_url_content`, `browser_subagent` (if interactive)

### Step 4: DRAFT
Synthesize findings:
```
1. Combine information from all sources
2. Structure logically (intro, body, conclusion)
3. Cite sources inline
4. Identify any remaining gaps
```

### Step 5: CRITIQUE (Mandatory)
Self-reflect on the draft:
```
Use sequential-thinking MCP to answer:
1. Does the draft fully answer the original question?
2. Are there factual gaps or assumptions?
3. Are sources authoritative and cited?
4. What would an expert critic point out?
5. Score quality 1-10. Must be ≥7 to proceed.
```
**Tool**: `mcp_sequential-thinking_sequentialthinking`

### Step 6: REVISE
If critique score < 7:
```
1. Address each gap identified
2. Search for additional sources if needed
3. Re-draft affected sections
4. Return to Step 5 (max 2 iterations)
```

## Quality Threshold
- **Minimum score**: 7/10 to finalize
- **Max iterations**: 2 revision cycles
- **Fallback**: If still <7, flag for human review

## Output Format
```markdown
# [Research Topic]

## Summary
[1-2 sentence answer]

## Key Findings
- Finding 1 (Source: [link])
- Finding 2 (Source: [link])
- Finding 3 (Source: [link])

## Detailed Analysis
[Structured synthesis]

## Sources
1. [Source 1 title](url)
2. [Source 2 title](url)

## Quality Notes
- Critique score: X/10
- Gaps addressed: [list]
- Limitations: [any remaining caveats]
```

## Integration
- Called by: `context-orchestrator` on research patterns
- Uses: `search_web`, `read_url_content`, `sequential-thinking` MCP
- Outputs to: Response or artifact file for complex research

## Anti-Patterns
- ❌ Skip critique step (even if first draft seems good)
- ❌ Use only one source
- ❌ Accept low-quality search results without refining
- ❌ Exceed 2 revision iterations (diminishing returns)
