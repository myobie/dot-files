#!/usr/bin/env bash

curl -fsSL https://claude.ai/install.sh | bash

npm i -g @openai/codex

curl -fsSL https://opencode.ai/install | bash

mkdir -p ~/bin
ln -sf ~/.opencode/bin/opencode ~/bin/opencode
