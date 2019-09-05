# Global variables
export EDITOR=code
export HOMEBREW_GITHUB_API_TOKEN=""
export JEKYLL_GITHUB_TOKEN=""
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export REACT_EDITOR=code
export TOOLCHAINS=swift

# Paths
export ANDROID_HOME=~/Library/Android/sdk
export JAVA_HOME=$(/usr/libexec/java_home)

PATH=$JAVA_HOME:$PATH
PATH=$ANDROID_HOME:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH
PATH=./node_modules/.bin:$PATH
export PATH

# Oh-my-zsh configurations
ZSH=$HOME/.oh-my-zsh
plugins=(git osx zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Loading nvm
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

# Pure prompt
autoload -U promptinit; promptinit
PURE_PROMPT_SYMBOL="λ"
prompt pure

# Aliases
alias adb-screenshot="adb shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > ~/Downloads/Android_screenshot_`date +%Y-%m-%d_%H.%M.%S`.png"
alias auth-ssh="ssh-add /Users/ethanify/.ssh/*_rsa"

alias gdf="git diff --color"
alias gs="git status"

alias launch-android-emu="cd $ANDROID_HOME/tools && emulator -avd"

alias rnclean="watchman watch-del-all && rm -rf node_modules && rm -fr $TMPDIR/react-* && npm cache clean --force && yarn cache clean"
alias rndev="adb shell input keyevent 82"
alias rnlog-android="adb logcat *:S ReactNative:V ReactNativeJS:V"

alias uptodate="brew update --verbose && brew upgrade --verbose && brew cleanup --prune-prefix && upgrade_oh_my_zsh --verbose"

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"
