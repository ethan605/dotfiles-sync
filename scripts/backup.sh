#!/bin/bash
source scripts/helpers.sh

# Updating system files
update_system_files() {
  print_step "Update system files"
  brew update --verbose && \
  brew upgrade --verbose && \
  # brew cask upgrade --verbose && \
  brew cleanup --prune-prefix && \
  env ZSH=~/.oh-my-zsh sh ~/.oh-my-zsh/tools/upgrade.sh --verbose
}

# Running backup scripts
backup() {
  print_step "Backup sources"
  unset PREFIX && \
  ./node_modules/.bin/gulp backup
}

commit_and_push() {
  print_step "Commit and push"
  git add ./backup && \
  git commit -m ":package: Backup" && \
  git push origin $(git branch --show-current)
}

update_system_files && \
backup && \
commit_and_push
