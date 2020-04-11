#!/bin/bash
WORKING_DIR=$HOME/.dotfiles
source $WORKING_DIR/scripts/helpers.sh

run_test() {
  cd $WORKING_DIR

  print_timestamp "Backup started"
  push_notification "Started"

  sleep 5

  print_timestamp "Backup finished" true
  push_notification "Finished" true
}

run_test
