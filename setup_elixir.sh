#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  echo 1>&2 "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

echo 1>&2 "**"
echo 1>&2 "** Setup elixir"
echo 1>&2 "**"

if [[ -n $(which mix) ]]; then
  if [[ ${force} == "1" ]]; then
    echo 'Y' | mix local.hex --force
  else
    echo 'Y' | mix local.hex --if-missing
  fi
fi
