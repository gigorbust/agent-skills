---
name: python-refactor
description: Python code quality expert. Refactors scripts for PEP 8 compliance, type safety (mypy), and modern Pythonic idioms. Use for "clean up script", "optimize python", "add types", "refactor".
allowed-tools: Read, Write, Edit, Bash, Grep
---

# Python Refactor Skill

## Purpose
Elevate Python scripts from "quick hacks" to "engineering grade" software.

## Capabilities

### 1. Modernization & Idioms
**Trigger:** "Refactor this script"
**Focus Areas:**
*   Replace `os.path` with `pathlib`.
*   Replace string formatting with `f-strings`.
*   Use `dataclasses` instead of raw dictionaries for structured data.
*   Use `with` statements for resource management (files, locks).

### 2. Type Safety
**Trigger:** "Add types", "Fix mypy errors"
**Action:**
*   Add `from typing import ...`
*   Annotate function signatures: `def my_func(x: int) -> str:`
*   **Goal**: Code should be self-documenting through its types.

### 3. Complexity Reduction
**Trigger:** "Simplify function"
**Action:**
*   Extract methods from long scripts.
*   Guard clauses: Replace deeply nested `if`s with early returns.
*   `if __name__ == "__main__":` block to prevent run-on-import.

## Workflow
1.  **Analyze**: Read the file. Identify high-complexity functions (Cognitive Complexity > 15).
2.  **Safety Check**: ARE THERE TESTS? If not, create a "snapshot test" (capture output) before changing logic.
3.  **Refactor**: Apply changes incrementally.
4.  **Verify**: Run the script/tests to ensure behavior is identical.
