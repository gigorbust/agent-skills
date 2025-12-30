---
name: fork-terminal
description: Use when context is becoming heavy or when needing to spawn parallel agent sessions. Creates new terminal windows with fresh AI agents (Claude, Gemini, Codex) and passes summarized context for seamless continuation. Use for context protection, parallel work, or offloading tasks to new sessions.
---

# Fork Terminal Skill

## Overview

Fork Terminal spawns new terminal windows with AI agents, passing summarized context for seamless work continuation. Essential for **context protection** when current session is becoming heavy.

## When to Use

- Context window approaching capacity
- Need parallel agent sessions
- Offloading isolated subtasks
- Starting fresh but continuing related work

## Core Commands

### Fork with Claude Code

```bash
# Fast model (Haiku)
osascript -e 'tell application "Terminal" to do script "claude -m haiku --dangerously-skip-permissions -p \"CONTEXT: [summary here]. TASK: [next task]\""'

# Base model (Sonnet)
osascript -e 'tell application "Terminal" to do script "claude --dangerously-skip-permissions -p \"CONTEXT: [summary here]. TASK: [next task]\""'
```

### Fork with Gemini CLI

```bash
# Fast model (Flash)
osascript -e 'tell application "Terminal" to do script "gemini -m flash -p \"CONTEXT: [summary here]. TASK: [next task]\""'

# Base model (Pro)
osascript -e 'tell application "Terminal" to do script "gemini -p \"CONTEXT: [summary here]. TASK: [next task]\""'
```

### Fork with Raw CLI

```bash
# Any CLI command
osascript -e 'tell application "Terminal" to do script "[command]"'
```

## Fork Summary Template

When forking, summarize context in this YAML format:

```yaml
history: |
  ## Work Completed
  - [Bullet points of completed work]
  
  ## Key Decisions
  - [Important decisions made]
  
  ## Relevant Files
  - [List of files touched]

next_user_request: |
  [Specific next task for the new agent]
```

## Model Selection

| Speed Needed | Claude | Gemini |
|:-------------|:-------|:-------|
| Fast | haiku | flash |
| Balanced | sonnet | pro |
| Deep reasoning | opus | pro-thinking |

## Example Usage

**Heavy context scenario:**

```
You: Fork terminal, use Claude fast model, summarize work done and continue with implementing the API endpoints

[Agent writes fork summary]
[Agent spawns: osascript -e 'tell application "Terminal" to do script "claude -m haiku -p \"CONTEXT: Completed CMS sync for 96 pages, created backend module meztal-sync.jsw. TASK: Implement HTTP function endpoints for external API access\""']
```

## Integration

**Pairs with:**
- `context-orchestrator` - Knows when to suggest forking
- `subagent-driven-development` - Alternative for parallel work

**Called by:**
- Any skill when context protection is needed
- User when wanting parallel sessions

## Red Flags

**Never:**
- Fork without summarizing context
- Lose critical information in summary
- Assume new agent has current context

**Always:**
- Include key decisions in summary
- Specify the model appropriately
- Provide clear next task
