#!/usr/bin/env bash

repo=$1

curl -fsSL https://claude.ai/install.sh | bash

npm i -g @openai/codex

curl -fsSL https://opencode.ai/install | bash

mkdir -p ~/bin
ln -sf ~/.opencode/bin/opencode ~/bin/opencode

if [[ -f "$repo/ai/.claude-plugin/marketplace.json" ]]; then
  if claude plugin marketplace list --json 2>/dev/null | grep -Eq '"name"[[:space:]]*:[[:space:]]*"local"'; then
    claude plugin marketplace update local >/dev/null 2>&1 || true
  else
    claude plugin marketplace add "$repo/ai"
  fi
fi
