#!/usr/bin/env bash

set -eo pipefail

os=$1
cpu=$2
repo=$3

if [[ -z ${os} || -z ${cpu} || -z ${repo} ]]; then
  1>&2 echo "Incorrect arguments given to setup_gpg.sh; os: $os cpu: $cpu repo: $repo"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup gpg"
1>&2 echo "**"

mkdir -p ~/.gnupg

pushd ${repo}/shared/gnupg > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/shared/gnupg/${filename}
    ln -v -f -s ${full} ~/.gnupg/${filename}
  fi
done

popd > /dev/null
pushd ${repo}/${os}/gnupg > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/${os}/gnupg/${filename}
    ln -v -f -s ${full} ~/.gnupg/${filename}
  fi
done

popd > /dev/null
pushd ${repo}/${os}-${cpu}/gnupg > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/${os}-${cpu}/gnupg/${filename}
    ln -v -f -s ${full} ~/.gnupg/${filename}
  fi
done

popd > /dev/null