#!/usr/bin/env bash

repo=$1
force=$2

if [[ -n $(which brew) ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ln -f -s ${repo}/Brewfile ~/.Brewfile

if [[ ${force} == "1" ]]; then
  brew bundle --global --no-lock
else
  brew bundle --global --no-upgrade --no-lock
fi