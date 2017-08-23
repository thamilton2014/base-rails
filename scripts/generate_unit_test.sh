#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
set -vx

if [ -z "$1" ]; then
    print("[Error] Missing parameter 'file_name'"
    exit 1
fi
touch spec/requests/"$1"_spec.rb
touch spec/factories/"$1".rb