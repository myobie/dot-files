#!/usr/bin/env bash

set -eo pipefail

1>&2 echo "**"
1>&2 echo "** Setup git lfs"
1>&2 echo "**"

if [[ -n $(which git) ]]; then
  git lfs install --system
fi