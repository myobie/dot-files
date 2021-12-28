#!/usr/bin/env bash

set -eo pipefail

repo=$1
force=$2

if [[ -z ${repo} || -z ${force} ]]; then
  echo 1>&2 "Incorrect arguments given to setup_vim.sh; repo: $repo force: $force"
  exit 1
fi

echo 1>&2 "**"
echo 1>&2 "** Setup vim"
echo 1>&2 "**"

if [[ -n $(which vim) ]]; then
  mkdir -p ~/.vim/backup

  # plug

  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    curl -#fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
  elif [[ ${force} == "1" ]]; then
    vim +PlugUpdate +qall
  fi

  # spell check dictionary

  spell_file=${HOME}/.vim/spell/en.utf-8.add
  mkdir -p $(dirname ${spell_file})

  if [[ ! -f ${spell_file} || ${force} == "1" ]]; then
    vim "+set spell" +spelldump +2,2d "+sav! /tmp/spelldump.txt" +qall
    sed -i -e $'1s;^;/encoding=utf-8\\n;' /tmp/spelldump.txt
    cat /tmp/spelldump.txt | sed "s/'/’/g" >$spell_file
    vim "+mkspell! ${spell_file}" +qall
    rm /tmp/spelldump.txt
  fi
else
  echo 1>&2 "No vim."
fi
