#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  echo 1>&2 "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

echo 1>&2 "**"
echo 1>&2 "** Setup hub"
echo 1>&2 "**"

if [[ -n $(which hub) ]]; then
  if [[ ! -f ~/.config/hub || ${force} == "1" ]]; then
    echo 1>&2 "Authenticating with hub..."
    hub api user
  fi

  # TODO: setup ~/.netrc correctly
fi
