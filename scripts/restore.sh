#!/bin/bash
source scripts/helpers.sh

NODE_VERSION=v12.16

read_json_array() {
  local json_path="$1"
  jq -r '.[]' "$json_path"
}

brew_restore_taps() {
  print_sub_step "Taps"
  for tap in $(read_json_array ./backup/brew/taps.json); do
    brew tap "$tap"
  done
}

brew_restore_formulaes() {
  print_sub_step "Formulaes"
  brew install $(read_json_array ./backup/brew/formulaes.json)
}

brew_restore_casks() {
  print_sub_step "Casks"
  brew cask install $(read_json_array ./backup/brew/casks.json)
}

restore_homebrew() {
  print_step "Restore Homebrew"
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" && \
  # brew install jq && \
  # brew_restore_taps && \
  # brew_restore_formulaes && \
  # brew_restore_casks
}

nvm_restore_node_versions() {
  print_sub_step "Node versions"
  for version in $(read_json_array ./backup/nvm/nodeVersions.json); do
    nvm install "$version"
  done
}

nvm_restore_global_npm_packages() {
  print_sub_step "Global NPM packages"
  npm install --global $(read_json_array ./backup/nvm/globalNpmPackages.json)
}

restore_nvm() {
  print_step "Restore NVM"
  # brew install nvm && \
  # unset PREFIX && \
  # source $NVM_DIR/nvm.sh && \
  # nvm_restore_node_versions && \
  # nvm use --default --delete-prefix $NODE_VERSION && \
  # nvm alias default node && \
  # npm config set prefix $NVM_DIR/versions/node/$(nvm version node) && \
  nvm_restore_global_npm_packages
}

restore_homebrew && \
  restore_nvm
