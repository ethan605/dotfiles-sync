#!/usr/bin/env bash
readonly CYAN='\033[0;36m'
readonly GREEN='\033[0;32m'
readonly NORMAL='\033[0m'

PATH="/usr/local/bin:/usr/local/sbin:$(getconf PATH)"
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH

function format_date_time() {
  date +"%Y-%m-%d %H:%M:%S %z"
}

function main() {
  printf "\n${CYAN}Sync started at $(format_date_time)${NORMAL}\n"
  mbsync -a -c $HOME/.mbsyncrc && \
    cat $HOME/.mail/Primary/Inbox/.mbsyncstate && \
    printf "${GREEN}Sync done at $(format_date_time)${NORMAL}\n"
}

main
