#!/bin/bash
set -e

echo "=> build...."
go build bay/proxy/proxy.go
go build bay/tracker/tracker.go

echo "=> cp to dist folder"
mv proxy dist/
mv tracker dist/

echo "==> done"

