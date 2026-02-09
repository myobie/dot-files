---
name: fix
description: Use Codex CLI to diagnose and fix a bug, error, or failing test. Use when you want a second opinion on a bug or when Claude's fix isn't working.
---

# Codex Fix

Use Codex CLI to independently diagnose and fix a bug.

## 1) Build the prompt

From the user's request, construct a prompt for Codex that includes:

- The symptom (error message, unexpected behavior, failing test)
- Relevant file paths or function names if known
- Any context about what was tried already

## 2) Run Codex

Log output to a tmp directory:

```
CODEX_DIR="$(mktemp -d)/codex-fix"
mkdir -p "$CODEX_DIR"
codex --sandbox danger-full-access -a never exec "$PROMPT" | tee "$CODEX_DIR/fix.log"
```

## 3) Follow response contract

Structure the response as:

- **Root cause** — what's actually wrong and why
- **Fix applied** — what was changed, with file paths and line references
- **Risk** — anything the fix might break or leave unaddressed

After Codex finishes, review the changes and run tests to verify the fix.
