---
name: react-component-gen
description: React/TypeScript component generator. Scaffolds production-ready components with interfaces, CSS modules/Tailwind, and best practices. Use for "new component", "create react component", "scaffold UI".
allowed-tools: Write, Edit, Bash
---

# React Component Generator Skill

## Purpose
Rapidly scaffold consistent, type-safe React components to avoid manual boilerplate typing.

## Capabilities

### 1. Standard Component Scaffold
**Trigger:** "Create component [Name]"
**Output Structure:**
```typescript
// Components typically reside in: src/components/[Name]/
import React from 'react';
import styles from './[Name].module.css'; // or Tailwind classes

interface [Name]Props {
  title: string;
  children?: React.ReactNode;
  onAction?: () => void;
}

export const [Name]: React.FC<[Name]Props> = ({ title, children, onAction }) => {
  return (
    <div className={styles.container}>
      <h2 className="text-xl font-bold">{title}</h2>
      {children}
    </div>
  );
};
```

### 2. Pattern Enforcement
*   **Functional Components**: Always use functional components with hooks. No class components.
*   **Strict Typing**: No `any`. Define interfaces for all props.
*   **Index Export**: Create `index.ts` in the folder for cleaner imports (`import { Component } from './components/Component'`).

## Workflow
1.  **Check Location**: Confirm where the component should live (e.g., `src/components` vs `src/features`).
2.  **Check Styling**: Detect if project uses Tailwind, CSS Modules, or styled-components. Match the existing style.
3.  **Generate**: Create the file(s).
