#!/bin/sh

set -eux

version="$(git rev-parse HEAD)"
remote="${1:-origin}"
remote_url="$(git remote get-url "$remote")"

sbt clean metadoc-site js/fullOptJS::webpack
cp -a target/metadoc/* metadoc-js/target/app/

cd metadoc-js/target/app
git init
git add .
git commit -m "Update demo to version $version"
git push -f "$remote_url" master:gh-pages
