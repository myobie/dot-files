#!/usr/bin/env bash

force=$1

if [[ -n $(which rustup-init) -o ${force} == "1" ]]; then
  rustup-init -y --no-modify-path
fi