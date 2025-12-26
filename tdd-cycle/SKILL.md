---
name: tdd-cycle
description: Enforces the Red-Green-Refactor cycle for atomic commits. Use when implementing ANY new feature or writing code.
allowed-tools: Bash, Read, Edit, Git
---

# Bite-Sized TDD Cycle

## Instructions
1.  **Start Cycle:** Run the enforcer script:
    ```bash
    ~/.claude/skills/tdd-cycle/scripts/tdd-cycle.sh
    ```
     *(Note: This is also aliased globally as `tdd-cycle`)*

2.  **Red:** Write a failing test case. Confirm it fails.
3.  **Green:** Write the *minimal* code to make it pass. Confirm it passes.
4.  **Refactor:** Clean up the code without changing behavior.
5.  **Commit:** The script will prompt for a commit message and commit automatically.

## Best Practices
*   **One Step at a Time:** Do not implement the whole feature at once.
*   **Atomic Commits:** Each cycle produces one committable unit.
*   **Test First:** Never write code without a failing test.
