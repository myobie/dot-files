#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  1>&2 echo "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup elixir"
1>&2 echo "**"

if [[ ${force} == "1" ]]; then
  echo 'Y' | mix local.hex --force
else
  echo 'Y' | mix local.hex --if-missing
fi