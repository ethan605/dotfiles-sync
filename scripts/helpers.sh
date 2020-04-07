#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

BOLD='\033[1m'
NORMAL='\033[0m'

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
