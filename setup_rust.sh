#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  1>&2 echo "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup rust"
1>&2 echo "**"

if [[ -n $(which rustup-init) || ${force} == "1" ]]; then
  rustup-init -y --no-modify-path
fi