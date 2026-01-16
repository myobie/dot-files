#!/usr/bin/env bash

set -eo pipefail

echo 1>&2 "**"
echo 1>&2 "** Setup Lix (Nix package manager)"
echo 1>&2 "**"

if command -v nix &> /dev/null; then
  echo "Lix/Nix already installed, skipping"
  exit 0
fi

curl -sSf -L https://install.lix.systems/lix | sh -s -- install
