#!/bin/bash

cd dirname($0)

os=unknown
cpu=unknown
repo=$(cd $(dirname $0) && pwd)
force=0

if [[ $1 == "force" || $1 == "--force" ]]; then
  force=1
fi

if [[ $OSTYPE == "linux-gnu"* ]]; then
  os=linux

  if [[ $(uname -a | awk '{ print $(NF-1) }') == "x86_64"* ]]; then
    cpu=x86
  else
    cpu=arm
  fi
elif [[ $OSTYPE == "darwin"* ]]; then
  os=mac

  if [[ $(uname -a | awk '{ print $(NF) }') == "arm"* ]]; then
    cpu=arm
  else
    cpu=x86
  fi
else
  1>&2 echo "Cannot install on this OS: ${OSTYPE}"
  exit 2
fi

${repo}/setup_bash.sh $os $cpu $repo

if [[ ${os} == "mac" ]]; then
  ${repo}/setup_brew.sh $repo $force
fi

${repo}/setup_dots.sh $os $arch $repo
${repo}/setup_elixir.sh $force
${repo}/setup_shfmt.sh $force
${repo}/setup_rust.sh $force
${repo}/setup_git_lfs.sh
${repo}/setup_hub.sh $force
${repo}/setup_gpg.sh $os $arch $repo
${repo}/setup_vim.sh $repo $force