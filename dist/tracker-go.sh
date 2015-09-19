#!/bin/bash
set -e

TIP=${TIP:-$1}

if [ -z "$TIP" ]
then
  echo 'ERROR: you should append tracker ip just like:'
  echo './tracker 10.3.11.2'
  exit 0
fi

echo "===>P2 Docker Pull Tracker"
./tracker  -listen ${TIP}:8888 -tracker ${TIP}:6881 -root /tmp

echo "done"
