# Global variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Rewrite $PATH
PATH="/usr/local/bin:/usr/local/sbin:$(getconf PATH)"

# Replace macOS utilities with GNU ones
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
PATH="/usr/local/opt/gnu-indent/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME=$(/usr/libexec/java_home)
PATH=$JAVA_HOME:$PATH
PATH=$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

# Local node env
export PATH=./node_modules/.bin:$PATH

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
export TOOLCHAINS=swift

# Ctrl + ] to move forward by word
bindkey "^]" forward-word

# Color for less and man 
__load-manpage-colors() {
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
}

__load-nvm() {
  export NVM_DIR=/usr/local/opt/nvm

  if [[ -s $NVM_DIR/nvm.sh ]]; then
    source $NVM_DIR/nvm.sh --no-use
  fi
}

# Auto call `nvm use` in folders with .nvmrc
__load-nvmrc() {
  local node_version=$(nvm version)
  local nvmrc_path=$(nvm_find_nvmrc)

  if [[ -n $nvmrc_path ]]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [[ $nvmrc_node_version = "N/A" ]]; then
      nvm install
    elif [[ $nvmrc_node_version != $node_version ]]; then
      nvm use
    fi
  elif [[ $node_version != $(nvm version default) ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# Oh-my-zsh configurations
__load-oh-my-zsh() {
  ZSH=$HOME/.oh-my-zsh
  plugins=(git npm vi-mode)
  fpath+=(~/.zsh_functions ~/.zsh-defer)
  source $ZSH/oh-my-zsh.sh
  source /usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

# Pure prompt
__load-pure-prompt() {
  PURE_PROMPT_SYMBOL="λ"            # originally "❯"
  PURE_PROMPT_VICMD_SYMBOL="ε"      # originally "❮"
  prompt pure
}

__load-pyenv() {
  [[ $(command -v pyenv) ]] && eval "$(pyenv init -)"
}

__load-rvm() {
  rvm use default
}

autoload -U add-zsh-hook; add-zsh-hook chpwd __load-nvmrc
autoload -U promptinit; promptinit
autoload -Uz zsh-defer

__load-oh-my-zsh
__load-pure-prompt
__load-manpage-colors
__load-pyenv

# Aliases
alias adb-screenshot="adb shell screencap -p \
  | perl -pe 's/\x0D\x0A/\x0A/g' > $HOME/Downloads/Android_screenshot_$(date +%Y-%m-%d_%H.%M.%S).png"

alias batc="env -uCOLORTERM bat --color always --number --wrap never --pager never"

alias docker-stop-all="docker stop -t0 $(docker ps -q)"
alias docker-rm-all="docker rm $(docker ps -laq)"

alias npm-fix-prefix='nvm use --delete-prefix node && \
  npm config set prefix $NVM_DIR/versions/node/$(nvm version node)'

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"

alias rnclean="watchman watch-del-all &&
  rm -rf node_modules &&
  rm -fr $TMPDIR/react-* &&
  npm cache clean --force &&
  yarn cache clean"
alias rndev="adb shell input keyevent 82"
alias rnlog-android="adb logcat *:S ReactNative:V ReactNativeJS:V"

alias tmx="tmux attach -t default || tmux new -s default"

# Remap existing commands
alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls --almost-all --color --human-readable --time-style=+'[%Y-%m-%d %H:%M:%S]'"
alias rm="rm -i"
alias nano=nvim
alias vi=nvim

# Defered loads
zsh-defer __load-nvm
zsh-defer __load-nvmrc
zsh-defer __load-rvm

# Loading tmux with default session
# if [[ -z $TMUX ]]; then
  # tmx
# fi

