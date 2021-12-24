#!/usr/bin/env bash

os=$1
arch=$2
repo=$3

mkdir -p ~/.gnupg

for filepath in ${repo}/shared/gnupg/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.gnupg/${filename}
done

for filepath in ${repo}/${os}/gnupg/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.gnupg/${filename}
done

for filepath in ${repo}/${os}/${arch}/gnupg/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.gnupg/${filename}
done