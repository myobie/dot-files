#!/usr/bin/env bash

os=$1
arch=$2
repo=$3

for filepath in ${repo}/shared/dots/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.${filename}
done

for filepath in ${repo}/${os}/dots/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.${filename}
done

for filepath in ${repo}/${os}/${arch}/dots/*; do
  filename=$(basename ${filepath})
  ln -v -f -s ${filepath} ~/.${filename}
done