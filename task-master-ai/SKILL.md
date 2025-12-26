---
name: task-master-ai
description: Advanced task orchestration and management. Use for checking next tasks, parsing PRDs, and managing project state.
---

# Task Master AI

## Commands
*   `tm-next` (or `task-master next`): **View the next priority task.** Run this when you finish a task or start a session.
*   `tm-list` (or `task-master list`): View the full task queue.
*   `task-master parse-prd <file>`: ingest a Product Requirements Document to generate tasks.

## Workflow
1.  **Check Status:** Always run `tm-next` to see what to do.
2.  **Execute:** Use `tdd-cycle` or regular coding to complete the task.
3.  **Update:** Update the task status (currently manual or via specific TM commands if available).

## Configuration
TaskMaster is installed globally. Configuration is in `.taskmasterconfig` or defaults.
