#!/usr/bin/env bash

force=$1

if [[ ${force} == "1" ]]; then
  echo 'Y' | mix local.hex --force
else
  echo 'Y' | mix local.hex --if-missing
fi