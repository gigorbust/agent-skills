---
name: systematic-debugging
description: Enforces the Iron Law of debugging: No fixes without root cause investigation. Use when you encounter ANY error, bug, or unexpected behavior.
allowed-tools: Bash, Read, Edit
---

# Systematic Debugging

## Instructions
1.  **Stop.** Do not propose a fix yet.
2.  Run the enforcer script (located in this skill's scripts directory):
    ```bash
    ~/.claude/skills/systematic-debugging/scripts/sys-debug.sh
    ```
    *(Note: This is also aliased globally as `sys-debug`)*

3.  Follow the 4 phases:
    *   **Phase 1: Root Cause Investigation** (Trace errors, reproduce)
    *   **Phase 2: Pattern Analysis** (Compare with working examples)
    *   **Phase 3: Hypothesis** (Propose specific cause)
    *   **Phase 4: Implementation** (Only AFTER Phase 3 is documented)

## When to use
*   Test failures
*   Runtime errors
*   "It works on my machine" issues
*   Deployment failures
