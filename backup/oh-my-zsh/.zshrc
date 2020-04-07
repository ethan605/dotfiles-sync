# Global variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Paths
export ANDROID_HOME="~/Library/Android/sdk"
export JAVA_HOME=$(/usr/libexec/java_home)
PATH="/usr/local/bin:$(getconf PATH)" # To get nvm works in tmux
PATH="/usr/local/sbin:$PATH"
PATH=$JAVA_HOME:$PATH
PATH=$ANDROID_HOME:$PATH
PATH=$ANDROID_HOME/tools:$PATH
PATH=$ANDROID_HOME/platform-tools:$PATH
PATH=./node_modules/.bin:$PATH
export PATH

# Default editors
export EDITOR=nvim
export REACT_EDITOR=nvim

# Tokens
export HOMEBREW_GITHUB_API_TOKEN=""
export JEKYLL_GITHUB_TOKEN=""
export PITOP_GITHUB_TOKEN=""

# Google Cloud configs
export GOOGLE_APPLICATION_CREDENTIALS=""
export GOOGLE_PROJECT_ID=""

# Misc
export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
export GPG_TTY=$(tty)
export TOOLCHAINS=swift

# Color for less and man 
export MANPAGER='less -s -M +Gg'
export LESS="--RAW-CONTROL-CHARS"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1

# Loading nvm
export NVM_DIR=$(brew --prefix nvm)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Oh-my-zsh configurations
ZSH=$HOME/.oh-my-zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions
plugins=(docker git github npm nvm osx vi-mode zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

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
PURE_PROMPT_SYMBOL="λ"            # originally "❯"
PURE_PROMPT_VICMD_SYMBOL="ε"      # originally "❮"
prompt pure

# Aliases
alias adb-screenshot="adb shell screencap -p \
  | perl -pe 's/\x0D\x0A/\x0A/g' > ~/Downloads/Android_screenshot_`date +%Y-%m-%d_%H.%M.%S`.png"

alias docker-stop-all='docker stop -t0 $(docker ps -q)'
alias docker-rm-all='docker rm $(docker ps -laq)'

alias launch-android-emu="cd $ANDROID_HOME/tools && emulator -avd"

alias npm-fix-prefix="nvm use --delete-prefix node && \
  npm config set prefix $NVM_DIR/versions/node/$(nvm version node)"
alias nvm-upgrade='(
  cd "$NVM_DIR"
  git fetch --tags origin
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"'

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"

alias rnclean="watchman watch-del-all &&
  rm -rf node_modules &&
  rm -fr $TMPDIR/react-* &&
  npm cache clean --force &&
  yarn cache clean"
alias rndev="adb shell input keyevent 82"
alias rnlog-android="adb logcat *:S ReactNative:V ReactNativeJS:V"

alias nano=nvim
alias vi=nvim

alias tmx="tmux attach -t default || tmux new -s default"

# Loading tmux with default session
# if [ -z "$TMUX" ]; then
  # tmx
# fi
