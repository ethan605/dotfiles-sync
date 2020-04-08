#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

BOLD='\033[1m'
NORMAL='\033[0m'

BACKUP_CONTENT_URL=https://raw.githubusercontent.com/ethan605/dotfiles/master/backup
steps_count=0

print_step() {
  let steps_count++
  local message=$1
  printf "\n${GREEN}${BOLD}❯ ${steps_count}. ${message}${NORMAL}\n"
}

print_sub_step() {
  local message=$1
  printf "\n${CYAN}- ${message}${NORMAL}\n"
}

read_remote_json_array() {
  local backup_source="$1"
  curl -fsSL "$BACKUP_CONTENT_URL/$backup_source.json" | jq -r '.[]'
}

