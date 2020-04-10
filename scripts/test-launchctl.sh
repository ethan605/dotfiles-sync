#!/bin/bash
cd $HOME/Documents/Workspaces/Personal/dotfiles
source scripts/helpers.sh

print_timestamp "Backup started"
push_notification "Started"

sleep 5

print_timestamp "Backup finished" true
push_notification "Finished" true
