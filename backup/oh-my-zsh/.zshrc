# Add RVM to PATH for scripting
export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME=/Users/ethanify/Library/Android/sdk
export TOOLCHAINS=swift
export HOMEBREW_GITHUB_API_TOKEN=""
export JEKYLL_GITHUB_TOKEN=""
PATH=$JAVA_HOME:$HOME/.rvm/bin:$ANDROID_HOME:/usr/local/sbin:/usr/local/bin:/usr/local/heroku/bin:~/Library/Android/sdk/platform-tools:./node_modules/.bin:$PATH
export PATH

export LANG="en_US.UTF-8"
export REACT_EDITOR=code

# Oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Powerline theme
# Look in ~/.oh-my-zsh/custom/themes/
ZSH_THEME="powerline"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_PATH="short"
POWERLINE_RIGHT_A=""
POWERLINE_RIGHT_B="mixed"
POWERLINE_SHOW_GIT_ON_RIGHT="true"

plugins=(git osx zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias auth-ssh="ssh-add /Users/ethanify/.ssh/*_rsa"

alias checkswap="ls -la /private/var/vm/swapfile*"
alias cleanswap="sudo rm -rf /private/var/vm/swapfile*"

alias gdf="git diff --color"
alias gitx="/Applications/GitX.app/Contents/MacOS/GitX . &"
alias gs="git status"

alias policy.off="sudo spctl --master-disable"
alias policy.on="sudo spctl --master-enable"
alias postgres.running="ps auxwww | grep postgres"
alias postgres.start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias postgres.status="pg_ctl -D /usr/local/var/postgres status"
alias postgres.stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias postgres.trace="tail -f /usr/local/var/postgres/server.log"

alias rnclean="watchman watch-del-all && rm -rf node_modules && rm -fr $TMPDIR/react-* && npm cache clean --force && yarn cache clean"
alias rndev="adb shell input keyevent 82"

alias uptodate="brew update --verbose && brew upgrade --verbose && brew prune --verbose && brew cleanup --verbose && upgrade_oh_my_zsh --verbose"

alias vsc="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ."
alias vscode="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
