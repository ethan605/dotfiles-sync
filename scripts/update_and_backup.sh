#!/bin/bash

CYAN='\033[0;36m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

BOLD='\033[1m'
NORMAL='\033[0m'

print_step() {
  local step=$1
  local message=$2
  printf "\n${GREEN}${BOLD}❯ ${step}. ${message}${NORMAL}\n\n"
}

# Updating system files
update_system_files() {
  print_step 1 "Updating system files"
  brew update --verbose
  brew upgrade --verbose
  brew cleanup --prune-prefix
  env ZSH=~/.oh-my-zsh sh ~/.oh-my-zsh/tools/upgrade.sh --verbose
}

# Upgrading Node modules
update_node_modules() {
  print_step 2 "Upgrading Node modules"
  yarn upgrade
}

# Running backup scripts
backup() {
  print_step 3 "Backing up"
  gulp backup
}

update_system_files && update_node_modules && backup
