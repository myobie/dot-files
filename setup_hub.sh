#!/usr/bin/env bash

set -eo pipefail

force=$1

if [[ -z ${force} ]]; then
  1>&2 echo "Incorrect arguments given to setup_elixir.sh; force: $force"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup hub"
1>&2 echo "**"

if [[ -n $(which hub) ]]; then
  if [[ ! -f ~/.config/hub || ${force} == "1" ]]; then
    1>&2 echo "Authenticating with hub..."
    hub api user
  fi

  # TODO: setup ~/.netrc correctly
fi
