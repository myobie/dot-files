#!/usr/bin/env bash
set -euo pipefail

cd $(dirname $0)

./unmount-d2.sh
./unmount-hdd.sh
