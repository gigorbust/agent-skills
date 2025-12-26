# Prompt Engineering Skill

## Purpose
Optimize prompts to align with user intent, improve clarity, and maximize LLM output quality.

## When to Use
- User asks to improve/optimize a prompt
- Writing complex system prompts
- Creating few-shot examples
- Debugging poor LLM responses
- Building prompts for specific tasks (coding, analysis, creative)

## Core Principles

### 1. Clarity Over Cleverness
- Be explicit about what you want
- Avoid ambiguous language
- State constraints clearly

### 2. Structure Matters
```
[ROLE/CONTEXT]
[TASK DESCRIPTION]
[CONSTRAINTS/RULES]
[OUTPUT FORMAT]
[EXAMPLES (if needed)]
```

### 3. The CO-STAR Framework
- **C**ontext: Background information
- **O**bjective: What you want achieved
- **S**tyle: Writing style/tone
- **T**one: Emotional quality
- **A**udience: Who will read this
- **R**esponse: Format specification

## Optimization Techniques

### Chain of Thought (CoT)
Add "Let's think step by step" or explicitly request reasoning:
```
Before answering, explain your reasoning process.
```

### Few-Shot Learning
Provide 2-3 examples of desired input/output pairs:
```
Example 1:
Input: [example input]
Output: [example output]

Now process:
Input: [actual input]
```

### Negative Prompting
Explicitly state what NOT to do:
```
Do NOT:
- Include disclaimers
- Use bullet points
- Exceed 200 words
```

### Role Assignment
```
You are an expert [ROLE] with 20 years of experience in [DOMAIN].
Your task is to [OBJECTIVE].
```

## Common Fixes

| Problem | Solution |
|---------|----------|
| Too verbose | Add word/length limits |
| Off-topic | Add "Focus only on X" |
| Wrong format | Provide exact output template |
| Missing context | Add relevant background |
| Inconsistent | Add examples |
| Too generic | Add specific constraints |

## Quality Checklist

Before finalizing a prompt, verify:
- [ ] Clear objective stated
- [ ] Constraints defined
- [ ] Output format specified
- [ ] Relevant context provided
- [ ] Ambiguous terms clarified
- [ ] Examples included (if complex)
- [ ] Negative constraints added (if needed)

## Intent Alignment Process

1. **Identify Core Intent**: What does the user actually want?
2. **Surface Assumptions**: What context is missing?
3. **Define Success**: What does a good output look like?
4. **Add Guardrails**: What could go wrong?
5. **Test & Iterate**: Run, evaluate, refine

---

## Tools Available

### 1. Local CLI Tool
```bash
improve-prompt "Your prompt here"
improve-prompt -f prompt.txt
improve-prompt "prompt" --feedback "outputs are too verbose"
```

### 2. Claude Code MCP
The `cc-prompt-engineer` MCP is connected - provides:
- `optimize_prompt` - Optimize any prompt
- `interactive_refine` - Iterative refinement
- `analyze_prompt` - Quality analysis

### 3. Console Prompt Improver (Web)
Access at: https://console.anthropic.com
- Upload prompt template
- Add feedback on issues
- Get improved version with CoT reasoning

### 4. API Access (Experimental)
Endpoint: `POST /v1/experimental/improve_prompt`
Beta header: `prompt-tools-2025-04-02`
Status: Closed research preview (request access)
