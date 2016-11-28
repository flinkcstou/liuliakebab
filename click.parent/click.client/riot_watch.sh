#!/usr/bin/env bash

if [ ! -e node_modules/riot-cli/lib/index.js ] ; then
  npm install
fi

npm run watch
