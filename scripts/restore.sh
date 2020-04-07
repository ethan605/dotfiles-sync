#!/bin/bash
source scripts/helpers.sh

NODE_VERSION=v12.16

read_json_array() {
  local json_path="$1"
  jq -r '.[]' "$json_path"
}

brew_fetch_taps() {
  print_sub_step "Fetch taps"
  for tap in $(read_json_array ./backup/brew/taps.json); do
    brew tap "$tap"
  done
}

brew_install_formulaes() {
  print_sub_step "Install formulaes"
  brew install $(read_json_array ./backup/brew/formulaes.json)
}

brew_install_casks() {
  print_sub_step "Install casks"
  brew cask install $(read_json_array ./scripts/test_data.json)
}

install_homebrew() {
  print_step "Install Homebrew"
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
  # brew install jq && \
  # brew_fetch_taps && \
  brew_install_formulaes && \
  brew_install_casks
}

install_nvm() {
  print_step "Install NVM"
  brew install nvm && \
  unset PREFIX && \
  source $NVM_DIR/nvm.sh && \
  nvm install $NODE_VERSION && \
  nvm alias default node && \
  nvm use --delete-prefix node && \
  npm config set prefix $NVM_DIR/versions/node/$(nvm version node)
}

install_homebrew

# install_homebrew && \
  # install_nvm
