#!/bin/bash

set -eo pipefail

cd $(dirname $0)

os=unknown
cpu=unknown
repo=$(cd $(dirname $0) && pwd)
force=0

if [[ $1 == "force" || $1 == "--force" ]]; then
  force=1
fi

if [[ $OSTYPE == "linux-"* ]]; then
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
  echo 1>&2 "Cannot install on this OS: ${OSTYPE}"
  exit 2
fi

echo 1>&2 "**"
echo 1>&2 "** Install"
echo 1>&2 "** os: $os cpu: $cpu repo: $repo"
echo 1>&2 "**"

# source our profile so basic paths are setup
echo ". ${repo}/bash_init $os $cpu $repo"
. ${repo}/bash_init $os $cpu $repo

echo $?
echo "Sourced."

${repo}/setup_dots.sh $os $cpu $repo

echo "Dots setup."

if [[ ${os} == "mac" ]]; then
  ${repo}/setup_brew.sh $repo $force
  echo "brew setup."
fi

${repo}/setup_bash.sh $os $cpu $repo
echo "bash setup."

${repo}/setup_elixir.sh $force
echo "elixir setup."

${repo}/setup_shfmt.sh $force
echo "shfmt setup."

${repo}/setup_rust.sh $force
echo "rust setup."

${repo}/setup_git_lfs.sh
echo "git lfs setup."

${repo}/setup_coding_agents.sh $repo
echo "coding agents setup."

${repo}/setup_zellij.sh
echo "zellij setup."

echo "Done."
