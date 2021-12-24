#!/usr/bin/env bash

set -eo pipefail

repo=$1
force=$2

if [[ -z ${repo} || -z ${force} ]]; then
  1>&2 echo "Incorrect arguments given to setup_brew.sh; repo: $repo force: $force"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup brew"
1>&2 echo "**"

if [[ -z $(which brew) ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ln -f -s ${repo}/mac/Brewfile ~/.Brewfile

if [[ ${force} == "1" ]]; then
  brew bundle --verbose --global --no-lock
else
  brew bundle --verbose --global --no-upgrade --no-lock
fi