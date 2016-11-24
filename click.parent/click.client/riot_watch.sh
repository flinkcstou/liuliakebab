#!/usr/bin/env bash

if [ ! -e node_modules/riot-cli/lib/index.js ] ; then
  npm install
fi

node node_modules/riot-cli/lib/index.js -w www2/app/ www2/compile/js/all.js 
