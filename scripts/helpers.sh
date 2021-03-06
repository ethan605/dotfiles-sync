#!/usr/bin/env bash
readonly CYAN='\033[0;36m'
readonly GREEN='\033[0;32m'
readonly ORANGE='\033[0;33m'
readonly RED='\033[0;31m'
readonly YELLOW='\033[1;33m'

readonly BOLD='\033[1m'
readonly NORMAL='\033[0m'

steps_count=0

function print_step() {
  steps_count=$((steps_count+1))
  local message=$1
  printf "\n${GREEN}${BOLD}❯ ${steps_count}. ${message}${NORMAL}\n"
}

function print_sub_step() {
  local message=$1
  printf "\n${CYAN}- ${message}${NORMAL}\n"
}

function format_date_time() {
  date +"%Y-%m-%d %H:%M:%S %z"
}

function print_timestamp() {
  local prefix=$1
  local show_commit_hash=${2:-false}
  local commit_hash=$(/usr/local/bin/git rev-parse HEAD)
  local commit_url="https://github.com/ethan605/dotfiles/commit/$commit_hash"

  if [[ $show_commit_hash = true ]]; then
    printf "\n${ORANGE}$prefix at $(format_date_time)\n${GREEN}Commit URL: $commit_url${NORMAL}\n"
  else
    printf "\n${ORANGE}$prefix at $(format_date_time)${NORMAL}\n"
  fi
}

function push_notification() {
  local timestamp="$1 at: $(format_date_time)"
  local show_commit_hash=${2:-false}
  local commit_hash=$(/usr/local/bin/git rev-parse --short HEAD)
  local title="Scheduled dotfiles backup"
  local sender="com.apple.Automator"

  if [[ $show_commit_hash = true ]]; then
    /usr/local/bin/terminal-notifier \
      -message "Commit hash: $commit_hash" \
      -title "$title" \
      -subtitle "$timestamp" \
      -sender $sender
  else
    /usr/local/bin/terminal-notifier \
      -message "$timestamp" \
      -title "$title" \
      -sender $sender
  fi
}

function setup_nvm() {
  export NVM_DIR=/usr/local/opt/nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  nvm use --delete-prefix $(cat $NVM_DIR/alias/default)
}

