#! /bin/bash

current_path=$( pwd )
browser_drivers_path="$current_path/browser_drivers"
echo $browser_drivers_path
if echo $PATH | grep -q  $browser_drivers_path;
then
  echo 'browser drivers path is already set'
else
  echo 'adding browser drivers path to $PATH'
  echo "export PATH=\"\$PATH:$browser_drivers_path\"" >> ~/.bashrc
  source ~/.bashrc
  echo 'browser driver path added successfully'
  exec bash
fi
