#!/usr/bin/env bash

set -eo pipefail

REPO=$(cd "$(dirname "$0")" && pwd)
SRC=~/src/github.com

echo 1>&2 "**"
echo 1>&2 "** Vendor kitty kittens"
echo 1>&2 "**"

# 1Password kitten
echo 1>&2 "** kitty-kitten-1password"
if [[ -d "$SRC/zdavison/kitty-kitten-1password" ]]; then
  git -C "$SRC/zdavison/kitty-kitten-1password" pull
else
  mkdir -p "$SRC/zdavison"
  git clone https://github.com/zdavison/kitty-kitten-1password "$SRC/zdavison/kitty-kitten-1password"
fi
cp "$SRC/zdavison/kitty-kitten-1password/onepassword_kitten.py" "$REPO/shared/dots/config/kitty/"

# Search kitten
echo 1>&2 "** kitty-kitten-search"
if [[ -d "$SRC/trygveaa/kitty-kitten-search" ]]; then
  git -C "$SRC/trygveaa/kitty-kitten-search" pull
else
  mkdir -p "$SRC/trygveaa"
  git clone https://github.com/trygveaa/kitty-kitten-search "$SRC/trygveaa/kitty-kitten-search"
fi
mkdir -p "$REPO/shared/dots/config/kitty/kittens/search"
cp "$SRC/trygveaa/kitty-kitten-search/search.py" "$REPO/shared/dots/config/kitty/kittens/search/"
cp "$SRC/trygveaa/kitty-kitten-search/scroll_mark.py" "$REPO/shared/dots/config/kitty/kittens/search/"
