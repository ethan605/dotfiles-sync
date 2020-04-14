#!/bin/bash
WORKING_DIR=$HOME/.dotfiles
PATH=/usr/local/bin:$PATH
ZSH=$HOME/.oh-my-zsh

source $WORKING_DIR/scripts/helpers.sh
source /usr/local/opt/nvm/nvm.sh

update_system_sources() {
  print_step "Update system files"
  brew update --verbose
  brew upgrade --verbose
  brew cleanup --prune-prefix
  sh $HOME/.oh-my-zsh/tools/upgrade.sh --verbose
}

independent_update_tasks() {
  print_step "Run independent update tasks"
  brew cask upgrade --verbose
  nvim --headless +PlugUpgrade +PlugUpdate +CocUpdateSync +qa
}

run_gulp_tasks() {
  print_step "Backup sources"
  $WORKING_DIR/node_modules/.bin/gulp backup
}

commit_and_push() {
  print_step "Commit and push"
  git add ./backup
  git commit -m ":package: Backup"
  git push origin $(git branch --show-current)
}

backup() {
  cd $WORKING_DIR

  print_timestamp "Backup started" false
  push_notification "Started" false

  update_system_sources
  run_gulp_tasks
  commit_and_push
  independent_update_tasks

  print_timestamp "Backup finished" true
  push_notification "Finished" true
}

backup
