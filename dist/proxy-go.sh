#!/bin/bash
set -e

TIP=${TIP:-$1}

if [ -z "$TIP" ]
then
  echo 'ERROR: you should append tracker ip just like:'
  echo './proxy 10.3.11.2'
  exit 0
fi

echo "P2 Pull Proxy..."

./proxy -tracker http://${TIP}:8888/ -listen :443  -root /tmp
