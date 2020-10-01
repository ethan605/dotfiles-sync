#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

readonly WORKING_DIR=$HOME/.dotfiles
source $WORKING_DIR/scripts/helpers.sh

function run_test() {
  cd $WORKING_DIR
  setup_nvm

  print_timestamp "Backup started"
  push_notification "Started"

  which node

  print_timestamp "Backup finished" true
  push_notification "Finished" true
}

run_test
