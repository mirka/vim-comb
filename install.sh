#!/bin/bash

if $(which npm > /dev/null); then
  npm install
else
  echo "Sorry, npm could not be found."
  echo "You'll need to install CSScomb in the plugin directory to have this plugin work"
  echo "The plugin is installed to $(dirname $0)"
fi
