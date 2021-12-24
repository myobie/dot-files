#!/bin/bash

os=$1
cpu=$2
repo=$3

grep -e '^\/bin\/bash$' /etc/shells > /dev/null

if [[ $? == "1" ]]; then
  echo /bin/bash | sudo tee -a /etc/shells
fi

if [[ ${os} == "mac" ]]; then
  if [[ ${cpu} == "arm" ]]; then
    grep -e '^\/opt\/homebrew\/bin\/bash$' /etc/shells > /dev/null

    if [[ $? == "1" ]]; then
      echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
    fi

    chsh -s /opt/homebrew/bin/bash
  else
    grep -e '^\/usr\/local\/bin\/bash$' /etc/shells > /dev/null

    if [[ $? == "1" ]]; then
      echo /usr/local/bin/bash | sudo tee -a /etc/shells
    fi

    chsh -s /usr/local/bin/bash
  fi
else
  chsh -s /bin/bash
fi

ln -f -s ${repo}/bash_profile ~/.bash_profille
ln -f -s ${repo}/bashrc ~/.bashrc