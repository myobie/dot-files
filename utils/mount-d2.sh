#!/usr/bin/env bash
set -euo pipefail

VOLUME="D2"

if diskutil info "/Volumes/$VOLUME" >/dev/null 2>&1; then
  echo "$VOLUME already mounted"
else
  echo "Mounting $VOLUME..."
  diskutil mount "$VOLUME"
fi
