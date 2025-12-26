# Skill: Subagent-Driven Development (SDD)

## Description
A meta-skill for orchestrating complex workflows by dispatching specialized subagents. You act as the "Strategic Controller", breaking down plans into isolated tasks and verifying quality at each gate.

## Workflow Protocol

### 1. Planning & Dispatch
- **Input:** Reading an `implementation_plan.md` artifact.
- **Action:** Extract a single, independent task.
- **Dispatch:** Spawn a fresh subagent with focused context (Task text + Architecture ONLY).

### 2. Execution Phase (The Subagent)
- **Role:** "Skilled Implementer"
- **Mandate:** 
    1. Ask clarifying questions first.
    2. Write minimal, test-driven code.
    3. Run tests and self-correct.
- **Output:** A Candidate Branch or PR-ready code block.

### 3. Quality Gates (MANDATORY)
**Gate 1: Spec Compliance**
- *Reviewer Role:* Ensures code matches requirements EXACTLY. No "gold-plating".
- *Action:* Reject hard if requirements are missed or exceeded.

**Gate 2: Code Quality**
- *Reviewer Role:* Checks patterns, naming, and performance.
- *Action:* Reject "magic numbers", poor naming, or lack of tests.

### 4. Integration
- Once a task passes both gates, merge it and proceed to the next task in the plan.
