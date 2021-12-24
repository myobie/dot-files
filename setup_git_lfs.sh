#!/usr/bin/env bash

if [[ -n $(which git) ]]; then
  git lfs install --system
fi