#!/usr/bin/env bash

set -eo pipefail

os=$1
cpu=$2
repo=$3

if [[ -z ${os} || -z ${cpu} || -z ${repo} ]]; then
  echo 1>&2 "Incorrect arguments given to setup_gpg.sh; os: $os cpu: $cpu repo: $repo"
  exit 1
fi

echo 1>&2 "**"
echo 1>&2 "** Setup gpg"
echo 1>&2 "**"

mkdir -p ~/.gnupg

if [[ -d ${repo}/shared/gnupg ]]; then
  pushd ${repo}/shared/gnupg >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/shared/gnupg/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.gnupg/${filename}
      fi
    fi
  done

  popd >/dev/null
fi

if [[ -d ${repo}/${os}/gnupg ]]; then
  pushd ${repo}/${os}/gnupg >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/${os}/gnupg/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.gnupg/${filename}
      fi
    fi
  done

  popd >/dev/null
fi

if [[ -d ${repo}/${os}-${cpu}/gnupg ]]; then
  pushd ${repo}/${os}-${cpu}/gnupg >/dev/null

  for filepath in *; do
    if [[ -f ${filepath} ]]; then
      filename=$(basename ${filepath})
      full=${repo}/${os}-${cpu}/gnupg/${filename}
      if [[ -f ${full} ]]; then
        ln -v -f -s ${full} ~/.gnupg/${filename}
      fi
    fi
  done

  popd >/dev/null
fi
