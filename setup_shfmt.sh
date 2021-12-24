#!/usr/bin/env bash

force=$1

if [[ -n $(which go) ]]; then
  if [[ ${force} == "0" ]]; then
    if [[ -z $(which shfmt) ]]; then
      GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
    fi
  else
    GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt
  fi
fi