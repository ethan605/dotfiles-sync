#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

PATH=/usr/local/bin:$PATH
ZSH=$HOME/.oh-my-zsh

readonly WORKING_DIR=$HOME/.dotfiles

source $WORKING_DIR/scripts/helpers.sh
source /usr/local/opt/nvm/nvm.sh

function update_system_sources() {
  print_step "Update system files"
  brew update --verbose
  brew upgrade --verbose
  brew cleanup
  sh $HOME/.oh-my-zsh/tools/upgrade.sh --verbose
  nvim --headless +PlugUpgrade +PlugUpdate +qa
}

function independent_update_tasks() {
  print_step "Run independent update tasks"
  brew cask upgrade --verbose
}

function run_gulp_tasks() {
  print_step "Backup sources"
  ./node_modules/.bin/gulp backup
}

function commit_and_push() {
  print_step "Commit and push"
  git add ./backup
  git commit -m ":package: Backup"
  git push origin $(git branch --show-current)
}

function backup() {
  cd $WORKING_DIR

  print_timestamp "Backup started" false
  push_notification "Started" false

  update_system_sources && \
  run_gulp_tasks && \
  commit_and_push

  print_timestamp "Backup finished" true
  push_notification "Finished" true
}

backup
independent_update_tasks
