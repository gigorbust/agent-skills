---
name: document-generator
description: Generates high-quality documentation (README, ARCHITECTURE, CONTRIBUTING) by analyzing directory structure and code content. Use when you need to document a new project, update existing docs, or explain complex codebases. Triggers on "generate docs", "write readme", "document this", "create architecture doc".
allowed-tools: Read, Grep, Glob, Bash, Edit, Write
---

# Document Generator Skill

## Purpose
Automates the creation of standard project documentation. Ensures consistency and completeness across different modules (e.g., specific sub-projects within a monorepo).

## Capabilities

### 1. README Generation
**Trigger:** "Generate README for [directory]"
**Steps:**
1.  **Scan**: `ls -F` and `kb-scan` (if available) or extensive `glob` to understand file types.
2.  **Context**: Read `package.json`, `setup.py`, or main entry points to understand the "What" and "How".
3.  **Draft**: Create a `README.md` with:
    *   **Title & Description**: Clear, 1-line summary.
    *   **Installation**: `npm install`, `pip install`, etc.
    *   **Usage**: Example CLI commands or code snippets.
    *   **Structure**: Brief tree of key files.

### 2. Architecture Documentation
**Trigger:** "Create architecture doc"
**Steps:**
1.  **Identify Components**: Group files by domain (e.g., API, Database, UI).
2.  **Map Data Flow**: detailed analysis of how data moves (imports, function calls).
3.  **Output**: Write `ARCHITECTURE.md` using Mermaid diagrams if helpful.

### 3. Contribution Guide
**Trigger:** "Create contributing guide"
**Steps:**
1.  Determine standard tooling (Prettier? Black? ESLint?).
2.  Write `CONTRIBUTING.md` with steps for:
    *   Environment Setup
    *   Linting/Formatting commands
    *   PR Process

## Best Practices
*   **Always read before writing**: Never hallucinate dependencies. Check the manifest files.
*   **Keep it concise**: Users don't read walls of text. Use bullet points.
*   **Live Links**: Use relative paths `[link](path/to/file)` so they work in GitHub.
