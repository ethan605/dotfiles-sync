# Global variables
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Rewrite $PATH
PATH="/usr/local/bin:/usr/local/sbin:$(getconf PATH)"

# Replace macOS utilities with GNU ones
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/diffutils/bin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
PATH="/usr/local/opt/gnu-indent/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Use JDK by Homebrew
export JDK_HOME="/usr/local/opt/openjdk"
export JAVA_HOME="$JDK_HOME/bin"
PATH="$JAVA_HOME:$PATH"

# Local node env
PATH=./node_modules/.bin:$PATH

# Global rvm env
export PATH="$HOME/.rvm/bin:$PATH"

# Default editors
export EDITOR=nvim
export REACT_EDITOR=nvim

# Onfido
export SDK_TOKEN_FACTORY_SECRET=""
export LOKALISE_TOKEN=""
export LOKALISE_PROJECT_ID=""
export BROWSERSTACK_USERNAME=""
export BROWSERSTACK_ACCESS_KEY=""

# Misc
# export FZF_DEFAULT_COMMAND='rg --files --hidden --smartcase --glob "!.git/*"'
export TOOLCHAINS=swift

# Ctrl + ] to move forward by word
bindkey "^]" forward-word

__load-autojump() {
  [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
}

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
  export NVM_LAZY_LOAD=true

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
      nvm use --delete-prefix
    elif [[ $nvmrc_node_version != $node_version ]]; then
      nvm use --delete-prefix
    fi
  elif [[ $node_version != $(nvm version default) ]]; then
    echo "Reverting to nvm default version"
    nvm use --delete-prefix default
  fi
}

# Pure prompt
__load-pure-prompt() {
  PURE_PROMPT_SYMBOL="λ"            # originally "❯"
  PURE_PROMPT_VICMD_SYMBOL="ε"      # originally "❮"
  prompt pure
}

__load-pyenv() {
  command -v pyenv > /dev/null && eval "$(pyenv init -)"
}

__load-zsh-plugins() {
  ZSH=$HOME/.oh-my-zsh
  plugins=(git npm vi-mode)
  fpath+=(~/.zsh_functions)
  source $ZSH/oh-my-zsh.sh
  source /usr/local/opt/zsh-autosuggestions/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
}

autoload -U add-zsh-hook; add-zsh-hook chpwd __load-nvmrc
autoload -U promptinit; promptinit

__load-manpage-colors
__load-autojump
__load-zsh-plugins
__load-pure-prompt
__load-nvm
# __load-nvmrc
__load-pyenv

# Aliases
alias adb-screenshot="adb shell screencap -p | \
  perl -pe 's/\x0D\x0A/\x0A/g' > \
  $HOME/Downloads/Android_screenshot_$(date +%Y-%m-%d_%H.%M.%S).png"

alias batc="env -uCOLORTERM bat --number --color always --theme 'Sublime Snazzy' --wrap never"

alias color-palette="curl -s https://gist.githubusercontent.com/ethan605/ea1b698c3395b9339748e8a0131136a5/raw | bash"

alias load-time="/usr/bin/time /usr/local/bin/zsh -ic exit"

alias policy-off="sudo spctl --master-disable"
alias policy-on="sudo spctl --master-enable"

alias tme="tmux attach -t ethanify || tmux new -s ethanify"
alias tmo="tmux attach -t onfido || tmux new -s onfido"

# Remap system commands
alias ls="ls --almost-all --color --human-readable --time-style=+'[%Y-%m-%d %H:%M:%S]'"
alias rm="rm -i"
alias nano=nvim
alias vi=nvim
