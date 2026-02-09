#!/usr/bin/env bash
set -euo pipefail

VOLUME="HDD"

if diskutil info "/Volumes/$VOLUME" >/dev/null 2>&1; then
  echo "Ejecting $VOLUME..."
  diskutil eject "/Volumes/$VOLUME"
else
  echo "$VOLUME already ejected"
fi
