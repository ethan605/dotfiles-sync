# Global variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export ANDROID_HOME=~/Library/Android/sdk
export EDITOR=code
export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
export GOOGLE_APPLICATION_CREDENTIALS="~/Documents/Workspaces/Dev/pi-top/matt-sandbox-155112-6b6046440734.json"
export GOOGLE_PROJECT_ID="matt-sandbox-155112"
export GPG_TTY=$(tty)
export HOMEBREW_GITHUB_API_TOKEN=""
export JAVA_HOME=$(/usr/libexec/java_home)
export JEKYLL_GITHUB_TOKEN=""
export REACT_EDITOR=code
export TOOLCHAINS=swift

PATH=$JAVA_HOME:$PATH
PATH=$ANDROID_HOME:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH
# PATH=./node_modules/.bin:$PATH
export PATH

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Oh-my-zsh configurations
ZSH=$HOME/.oh-my-zsh
plugins=(git osx zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Loading nvm
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

# Auto call `nvm use` in folders with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

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

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"

alias rnclean="watchman watch-del-all && rm -rf node_modules && rm -fr $TMPDIR/react-* && npm cache clean --force && yarn cache clean"
alias rndev="adb shell input keyevent 82"
alias rnlog-android="adb logcat *:S ReactNative:V ReactNativeJS:V"

alias uptodate="brew update --verbose && brew upgrade --verbose && brew cleanup --prune-prefix && upgrade_oh_my_zsh --verbose"
