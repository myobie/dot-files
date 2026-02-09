#!/usr/bin/env bash
set -euo pipefail

VOLUME="D2"

if diskutil info "/Volumes/$VOLUME" >/dev/null 2>&1; then
  echo "Ejecting $VOLUME..."
  diskutil eject "/Volumes/$VOLUME"
else
  echo "$VOLUME already ejected"
fi
