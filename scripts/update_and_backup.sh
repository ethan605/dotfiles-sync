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
  printf "\n${GREEN}${BOLD}❯ ${steps_count}. ${message}${NORMAL}\n\n"
}

# Updating system files
update_system_files() {
  print_step "Updating system files"
  brew update --verbose
  brew upgrade --verbose
  brew cask upgrade --verbose
  brew cleanup --prune-prefix
  env ZSH=~/.oh-my-zsh sh ~/.oh-my-zsh/tools/upgrade.sh --verbose
}

# Running backup scripts
backup() {
  print_step "Backing up"
  gulp backup
}

update_system_files && backup
