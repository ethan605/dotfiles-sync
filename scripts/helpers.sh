#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

CYAN='\033[0;36m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

BOLD='\033[1m'
NORMAL='\033[0m'

JOB_ID="ethanify.dotfiles.backup"
GITHUB_CONTENT_URL=https://raw.githubusercontent.com
BACKUP_CONTENT_URL=$GITHUB_CONTENT_URL/ethan605/dotfiles/master/backup
TEMP_DIR=/tmp/$JOB_ID

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

format_date_time() {
  date +"%Y-%m-%d %H:%M:%S %z"
}

print_timestamp() {
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

push_notification() {
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

clean_up() {
  print_step "Clean up temp files"
  rm -rf $TEMP_DIR
}

download_and_restore_file() {
  local source="$1"
  local dest="$2"
  curl -o $dest -fsSL $BACKUP_CONTENT_URL/$source
}

download_and_unzip() {
  local srcDir="$1"
  local srcFile="$2"
  local dest="$3"

  mkdir -p $TEMP_DIR/$srcDir && \
  curl -o $TEMP_DIR/$srcDir/$srcFile.zip -fsSL $BACKUP_CONTENT_URL/$srcDir/$srcFile.zip && \
  unzip -q -d $TEMP_DIR/$srcDir $TEMP_DIR/$srcDir/$srcFile.zip && \
  cp $TEMP_DIR/$srcDir/$srcFile/* $dest
}

read_remote_json_array() {
  local source="$1"
  curl -fsSL $BACKUP_CONTENT_URL/$source.json | jq -r '.[]'
}
