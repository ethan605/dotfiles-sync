#!/bin/bash
source scripts/helpers.sh

NODE_VERSION=v12.16

read_json_array() {
  local json_path="$1"
  jq -r '.[]' "$json_path"
}

brew_restore_taps() {
  print_sub_step "Restore taps"
  for tap in $(read_json_array ./backup/brew/taps.json); do
    brew tap "$tap"
  done
}

brew_restore_formulaes() {
  print_sub_step "Restore formulaes"
  brew install $(read_json_array ./backup/brew/formulaes.json)
}

brew_restore_casks() {
  print_sub_step "Restore casks"
  brew cask install $(read_json_array ./scripts/test_data.json)
}

restore_homebrew() {
  print_step "Install Homebrew"
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
  brew install jq && \
  brew_restore_taps && \
  brew_restore_formulaes && \
  brew_restore_casks
}

restore_nvm() {
  print_step "Install NVM"
  brew install nvm && \
  unset PREFIX && \
  source $NVM_DIR/nvm.sh && \
  nvm install $NODE_VERSION && \
  nvm alias default node && \
  nvm use --delete-prefix node && \
  npm config set prefix $NVM_DIR/versions/node/$(nvm version node)
}

restore_homebrew

# restore_homebrew && \
  # restore_nvm
