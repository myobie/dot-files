#!/usr/bin/env bash

set -eo pipefail

os=$1
cpu=$2
repo=$3

if [[ -z ${os} || -z ${cpu} || -z ${repo} ]]; then
  echo 1>&2 "Incorrect arguments given to setup_dots.sh; os: $os cpu: $cpu repo: $repo"
  exit 1
fi

echo 1>&2 "**"
echo 1>&2 "** Setup dots"
echo 1>&2 "**"

if [[ -d ${repo}/shared/dots ]]; then
  pushd ${repo}/shared/dots >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/shared/dots/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.${filename}
      fi
    fi
  done

  popd >/dev/null
fi

if [[ -d ${repo}/${os}/dots ]]; then
  pushd ${repo}/${os}/dots >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/${os}/dots/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.${filename}
      fi
    fi
  done

  popd >/dev/null
fi

if [[ -d ${repo}/${os}-${cpu}/dots ]]; then
  pushd ${repo}/${os}-${cpu}/dots >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/${os}-${cpu}/dots/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.${filename}
      fi
    fi
  done

  popd >/dev/null
fi
