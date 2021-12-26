#!/usr/bin/env bash

set -eo pipefail

os=$1
cpu=$2
repo=$3

if [[ -z ${os} || -z ${cpu} || -z ${repo} ]]; then
  1>&2 echo "Incorrect arguments given to setup_dots.sh; os: $os cpu: $cpu repo: $repo"
  exit 1
fi

1>&2 echo "**"
1>&2 echo "** Setup dots"
1>&2 echo "**"

pushd ${repo}/shared/dots > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/shared/dots/${filename}
    ln -v -f -s ${full} ~/.${filename}
  fi
done

popd > /dev/null
pushd ${repo}/${os}/dots > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/${os}/dots/${filename}
    ln -v -f -s ${full} ~/.${filename}
  fi
done

popd > /dev/null
pushd ${repo}/${os}-${cpu}/dots > /dev/null

for filepath in *; do
  if [[ -f ${filepath} ]]; then
    filename=$(basename ${filepath})
    full=${repo}/${os}-${cpu}/dots/${filename}
    ln -v -f -s ${full} ~/.${filename}
  fi
done

popd > /dev/null