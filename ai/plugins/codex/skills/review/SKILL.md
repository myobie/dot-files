---
name: review
description: Run consistent, findings-first code reviews with Codex CLI for any target: uncommitted/dirty working tree, current branch vs base branch, specific commit SHA, or pull request. Use when asked to review bugs, risks, regressions, and test gaps with actionable file/line findings.
---

# Codex Review

Execute one-shot code review flows with Codex CLI and return review-quality findings.

## 1) Select review mode

Infer mode from user intent:

- `uncommitted`: review staged/unstaged/untracked changes
- `base`: review current branch against a base branch
- `commit`: review a specific commit SHA
- `pr`: review a pull request target resolved by existing team workflow

Use `base=main` by default when mode is `base` and no base branch is provided.

## 2) Run Codex review command

Run with explicit non-interactive flags. Log output to a tmp directory:

```
REVIEW_DIR="$(mktemp -d)/codex-review"
mkdir -p "$REVIEW_DIR"
```

- Uncommitted:
`codex --sandbox read-only -a never exec review --uncommitted | tee "$REVIEW_DIR/review.log"`
- Branch vs base:
`codex --sandbox read-only -a never exec review --base "$BASE" | tee "$REVIEW_DIR/review.log"`
- Commit:
`codex --sandbox read-only -a never exec review --commit "$SHA" | tee "$REVIEW_DIR/review.log"`
- PR:
Resolve PR refs with existing workflow, then run branch-vs-base review.

Do not combine custom prompt text with `--uncommitted`, `--base`, or `--commit`.

## 3) Follow response contract

Return findings first, ordered by severity.

Include for each finding:

- severity
- file path and line reference
- risk or regression
- concrete fix recommendation

Then include:

- open questions or assumptions
- brief summary only after findings
- explicit "no findings" statement when applicable, plus residual testing risk

## 4) Handle failures explicitly

If review cannot run, report the exact blocker and next action.

Do not silently switch to a different review target.
