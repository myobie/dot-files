#!/bin/bash

set -eo pipefail

os=$1
cpu=$2
repo=$3

if [[ -z ${os} || -z ${cpu} || -z ${repo} ]]; then
  1>&2 echo "Incorrect arguments given to setup_bash.sh; os: $os cpu: $cpu repo: $repo"
  exit 1
fi

if [[ -z $(grep -e '^\/bin\/bash$' /etc/shells) ]]; then
  echo /bin/bash | sudo tee -a /etc/shells
fi

if [[ ${os} == "mac" ]]; then
  if [[ ${cpu} == "arm" ]]; then
    if [[ -z $(grep -e '^\/opt\/homebrew\/bin\/bash$' /etc/shells) ]]; then
      1>&2 echo "Adding /opt/homebrew/bin/bash shell to /etc/shells"
      echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
    fi

    if [[ ${SHELL} != "/opt/homebrew/bin/bash" ]]; then
      1>&2 echo "Changing shell to /opt/homebrew/bin/bash"
      chsh -s /opt/homebrew/bin/bash
    fi
  else
    if [[ -z $(grep -e '^\/usr\/local\/bin\/bash$' /etc/shells) ]]; then
      1>&2 echo "Adding /usr/local/bin/bash shell to /etc/shells"
      echo /usr/local/bin/bash | sudo tee -a /etc/shells
    fi

    if [[ ${SHELL} != "/usr/local/bin/bash" ]]; then
      1>&2 echo "Changing shell to /usr/local/bin/bash"
      chsh -s /usr/local/bin/bash
    fi
  fi
else
  if [[ ${SHELL} != "/bin/bash" ]]; then
    chsh -s /bin/bash
  fi
fi
