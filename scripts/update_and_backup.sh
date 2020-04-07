#!/bin/bash
source scripts/helpers.sh

# Updating system files
update_system_files() {
  print_step "Updating system files"
  # brew update --verbose && \
  # brew upgrade --verbose && \
  # brew cask upgrade --verbose && \
  brew cleanup --prune-prefix && \
  env ZSH=~/.oh-my-zsh sh ~/.oh-my-zsh/tools/upgrade.sh --verbose
}

# Running backup scripts
backup() {
  print_step "Backing up"
  unset PREFIX && \
  ./node_modules/.bin/gulp backup
}

update_system_files && backup
