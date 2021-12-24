#!/usr/bin/env bash

repo=$1

mkdir -p ~/.ssh
ln -v -s ${repo}/ssh_config ~/.ssh/config