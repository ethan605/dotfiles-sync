#!/bin/bash
WORK_DIR=$HOME/Documents/Workspaces/Personal/dotfiles
PATH=/usr/local/bin:$WORK_DIR/node_modules/.bin:$PATH
ZSH=$HOME/.oh-my-zsh
# unset PREFIX

source $WORK_DIR/scripts/helpers.sh
source /usr/local/opt/nvm/nvm.sh

update_system_sources() {
  print_step "Update system files"
  brew update --verbose && \
  brew upgrade --verbose && \
  brew cleanup --prune-prefix && \
  sh $HOME/.oh-my-zsh/tools/upgrade.sh --verbose
}

independent_update_tasks() {
  print_step "Run independent update tasks"
  brew cask upgrade --verbose
}

run_gulp_tasks() {
  print_step "Backup sources"
  gulp backup
}

commit_and_push() {
  print_step "Commit and push"
  git add ./backup && \
  git commit -m ":package: Backup" && \
  git push origin $(git branch --show-current)
}

print_timestamp "Start backup"

cd $WORK_DIR
update_system_sources
run_gulp_tasks
commit_and_push
independent_update_tasks

print_timestamp "Finish backup"
