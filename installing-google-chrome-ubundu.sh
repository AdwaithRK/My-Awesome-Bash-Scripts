#!/bin/bash

get_user () {
  me="$(whoami)"
}


update_and_upgrade () {
  sudo apt-get update
  sudo apt-get install google-chrome-stable
}


install_chrome () {
  if grep -Fxq "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" /etc/apt/sources.list.d/google-chrome.list
  then
  echo 'present'
  else
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
  fi
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  update_and_upgrade
}


install_rvm () {
  sudo apt-add-repository -y ppa:rael-gc/rvm
  sudo apt-get update
  sudo apt-get install rvm
  exec bash
  rvm install ruby
}


setup_js_runtime () {
  curl -sSL https://deb.nodesource.com/setup_6.x -o nodejs.sh
  less nodejs.sh
  cat /tmp/nodejs.sh | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
}


install_rails () {
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  cd /tmp
  cd /tmp
  curl -sSL https://get.rvm.io -o rvm.sh
  less /tmp/rvm.sh
  cat /tmp/rvm.sh | bash -s stable --rails
  get_user
  source "/home/$me/.rvm/scripts/rvm"
  setup_js_runtime
}


google_install_options () {
  echo "1. Install chrome 2. Update chrome \n"
  read -p "Enter option: " option
  echo $option
  if [ $option -eq 1 ]
  then
    install_chrome
  elif [ $option -eq 2 ]
  then
    update_and_upgrade
  fi
}

