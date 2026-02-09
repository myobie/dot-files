---
name: refactor
description: Use Codex CLI to refactor a module, file, or code pattern. Use when you want an independent take on how to restructure complex or tangled code.
---

# Codex Refactor

Use Codex CLI to analyze code and apply a refactor.

## 1) Build the prompt

From the user's request, construct a prompt for Codex that includes:

- The target (file, module, pattern, or concept to refactor)
- The goal (simplify, extract, decouple, rename, restructure, etc.)
- Any constraints (preserve API, maintain backwards compat, etc.)

## 2) Run Codex

Log output to a tmp directory:

```
CODEX_DIR="$(mktemp -d)/codex-refactor"
mkdir -p "$CODEX_DIR"
codex --sandbox danger-full-access -a never exec "$PROMPT" | tee "$CODEX_DIR/refactor.log"
```

## 3) Follow response contract

Structure the response as:

- **Current state** — what the code looks like now and why it's problematic
- **Changes applied** — what was changed, with file paths and line references
- **Trade-offs** — what improves, what gets more complex, what might break

After Codex finishes, review the changes and run tests to verify nothing broke.
