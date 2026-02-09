---
name: explain
description: Deep-dive into complex code using Codex CLI. Traces call chains, maps dependencies, and explains how code works. Use when asked to understand, unwind, or explain tangled or unfamiliar code.
---

# Codex Explain

Use Codex CLI to do a thorough, read-only deep-dive into code and report back a clear explanation.

## 1) Build the prompt

From the user's request, construct a focused prompt for Codex. The prompt should ask Codex to:

- Trace the relevant code paths end-to-end
- Identify key abstractions, data flow, and control flow
- Surface non-obvious dependencies or side effects
- Call out anything surprising or fragile

Include the target (file path, function name, module, or concept) in the prompt.

## 2) Run Codex

```
codex --sandbox read-only -a never exec "$PROMPT"
```

Do not use `| tee` unless the output is likely to be very large.

## 3) Follow response contract

Structure the explanation as:

- **What it does** — high-level purpose
- **How it works** — key code paths and flow
- **Connections** — dependencies, callers, side effects
- **Gotchas** — anything surprising, fragile, or easy to misunderstand

Keep it concrete. Reference specific files and lines, not abstract descriptions.
