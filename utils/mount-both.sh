#!/usr/bin/env bash
set -euo pipefail

cd $(dirname $0)

./mount-d2.sh
./mount-hdd.sh
