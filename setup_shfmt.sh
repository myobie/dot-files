#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  1>&2 echo "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup shfmt"
1>&2 echo "**"

if [[ -n $(which go) ]]; then
  if [[ ${force} == "1" || -z $(which shfmt) ]]; then
    GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
  fi
fi