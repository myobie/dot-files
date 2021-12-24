#!/usr/bin/env bash

set -eo pipefail

repo=$1

if [[ -z ${repo} ]]; then
  1>&2 echo "Incorrect arguments given to setup_ssh.sh; repo: $repo"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup ssh"
1>&2 echo "**"

mkdir -p ~/.ssh
ln -v -s ${repo}/ssh_config ~/.ssh/config