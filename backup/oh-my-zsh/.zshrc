export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME=/Users/ethanify/Library/Android/sdk
export TOOLCHAINS=swift
export HOMEBREW_GITHUB_API_TOKEN=""
export JEKYLL_GITHUB_TOKEN=""

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

PATH=/usr/local/share/dotnet:$PATH
PATH=/usr/local/heroku/bin:$PATH
PATH=/usr/local/sbin:$PATH
PATH=/usr/local/bin:$PATH
PATH=~/Library/Android/sdk/platform-tools:$PATH
PATH=./node_modules/.bin:$PATH
PATH=$ANDROID_HOME:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$JAVA_HOME:$PATH
PATH=$GEM_HOME/bin:$PATH
export PATH

export REACT_EDITOR=code

# Oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

plugins=(git osx zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

autoload -U promptinit; promptinit
PURE_PROMPT_SYMBOL="λ"
prompt pure

alias auth-ssh="ssh-add /Users/ethanify/.ssh/*_rsa"

alias gdf="git diff --color"
alias gdn="git diff --name-only"
alias gs="git status"

alias rnclean="watchman watch-del-all && rm -rf node_modules && rm -fr $TMPDIR/react-* && npm cache clean --force && yarn cache clean"
alias rndev="adb shell input keyevent 82"
alias rnfix-ios="cd ./node_modules/react-native && ./scripts/ios-install-third-party.sh && cd ./third-party/glog-0.3.4 && ./configure"
alias rnlog-android="adb logcat *:S ReactNative:V ReactNativeJS:V"

alias uptodate="brew update --verbose && brew upgrade --verbose && brew prune --verbose && brew cleanup && upgrade_oh_my_zsh --verbose"

alias adb-screenshot="adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > ~/Downloads/Android_screenshot_`date +%Y-%m-%d_%H.%M.%S`.png"

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"

alias link-system-node="ln -s $NVM_BIN/node /usr/local/bin/node"