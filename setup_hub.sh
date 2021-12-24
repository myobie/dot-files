#!/usr/bin/env bash

force=$1

if [[ -n $(which hub) ]]; then
  if [[ ! -f ~/.config/hub -o ${force} == "1" ]]; then
    1>&2 echo "Please authenticate with hub"
    hub api user
  fi

  # TODO: setup ~/.netrc correctly
fi