---
description: "Context Expert: Automatically pulls relevant skills/MCPs for every request"
---

# Context Expert Skill

## Description
This skill acts as a high-level "router" or "orchestrator" that analyzes every user request to determine the necessary context, tools, and skills required to fulfill it effectively. It ensures that the agent is always operating with the maximum available capabilities tailored to the specific task.

## Triggers
- Ideally, this logic applies to **every** complex user request.
- Explicit invocation: "Activate Context Expert", "Analyze Requirements".

## Instructions
When this skill is active (or when you are planning a task):

1.  **Analyze the Request**:
    - Identify the core technical domain (e.g., Frontend/React, Backend/Python, DevOps/Inngest).
    - Identify the specific goal (e.g., Refactoring, New Feature, Bug Fix).

2.  **Retrieve Context (The "Pull")**:
    - **Skills**: Check `~/.claude/skills` and `~/.agent/skills`. If the user asks for "React", pull in `react-component-gen`. If "Refactor", pull in `code-reviewer`.
    - **Web Components**: If "Lit", "Open-WC", or "Vanilla" is detected:
        - **Tools**: Recommend `lit-plugin` for VS Code and `Web Component DevTools` for the browser.
        - **Libraries**: Suggest **Shoelace** (versatile), **FAST** (performance), or **Lion** (white-label) based on the specific need.
        - **Standards**: Check for `custom-elements.json` (CEM) to ensure standardization.
    - **MCPs**: Check active MCP servers. If "Database" is mentioned, ensure the relevant DB MCP is used. If "Design", ensure Figma/Rive MCPs are active.
    - **Documentation**: Use `read_file` or `grep` to find relevant tech stack updates in `.gemini/antigravity/knowledge`.

3.  **Tailor the "Power Stack"**:
    - Construct a plan that explicitly lists the "Power Tools" being mobilized for this specific request.
    - *Example*: "For this React refactor, I am activating: `react-component-gen` skill, `eslint` MCP, and the `shadcn` pattern library."

4.  **Maximize Capabilities**:
    - Do not default to basic answers. Always check if a "Power Skill" exists to provide a 10x better output.
    - *Example*: Instead of writing a basic Python script, check if `script-wizard` skill exists to make it robust, typed, and documented.

## Goal
To eliminate manual context loading and ensure every response leverages the full weight of the available "Superpowers" globally.
