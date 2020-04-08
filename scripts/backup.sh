#!/bin/bash
source scripts/helpers.sh

update_system_sources() {
  print_step "Update system files"
  brew update --verbose && \
  brew upgrade --verbose && \
  brew cleanup --prune-prefix && \
  env ZSH=~/.oh-my-zsh sh ~/.oh-my-zsh/tools/upgrade.sh --verbose
}

independent_update_tasks() {
  print_step "Run independent update tasks"
  brew cask upgrade --verbose
}

backup() {
  print_step "Backup sources"
  PREFIX='' ./node_modules/.bin/gulp backup
}

commit_and_push() {
  print_step "Commit and push"
  git add ./backup && \
  git commit -m ":package: Backup" && \
  git push origin $(git branch --show-current)
}

update_system_sources && \
backup && \
commit_and_push

independent_update_tasks
