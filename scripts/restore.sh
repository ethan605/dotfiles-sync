#!/bin/bash
source scripts/helpers.sh

NODE_VERSION=v12.16
BREW_CONTENT_URL=https://raw.githubusercontent.com/Homebrew/install/master

brew_restore_taps() {
  print_sub_step "Taps"
  for tap in $(read_remote_json_array brew/taps); do
    brew tap "$tap"
  done
}

brew_restore_formulaes() {
  print_sub_step "Formulaes"
  brew install $(read_remote_json_array brew/formulaes)
}

brew_restore_casks() {
  print_sub_step "Casks"
  brew cask install $(read_remote_json_array brew/casks)
}

restore_homebrew() {
  print_step "Restore Homebrew"
  /bin/bash -c "$(curl -fsSL $BREW_CONTENT_URL/install.sh)" && \
  brew install jq && \
  brew_restore_taps && \
  brew_restore_formulaes && \
  brew_restore_casks
}

nvm_restore_node_versions() {
  print_sub_step "Node versions"
  for version in $(read_remote_json_array nvm/nodeVersions); do
    nvm install "$version"
  done
}

nvm_restore_global_npm_packages() {
  print_sub_step "Global NPM packages"
  npm install --global $(read_remote_json_array nvm/globalNpmPackages)
}

restore_nvm() {
  print_step "Restore NVM"
  brew install nvm && \
  unset PREFIX && \
  source $NVM_DIR/nvm.sh && \
  nvm_restore_node_versions && \
  nvm use --default --delete-prefix $NODE_VERSION && \
  nvm alias default node && \
  npm config set prefix $NVM_DIR/versions/node/$(nvm version node) && \
  nvm_restore_global_npm_packages
}

restore_pnupg() {
  print_step "Restore GnuPG"
  gpg --import ~/Downloads/gpg_private_key.asc && \
  gpg --edit-key thanhnx.605@gmail.com && \
  cp ./backup/gnupg/*.conf ~/.gnupg && \
  killall gpg-agent && \
  gpg-agent --daemon && \
  echo "test" | gpg --clearsign &> /dev/null
}

restore_secrets() {
  print_sub_step "Gradle"
  mkdir -p ~/.gradle && \
  gpgtar --decrypt --directory ~/.gradle ./backup/gradle.gpgtar

  print_sub_step "SSH"
  mkdir -p ~/.ssh && \
  gpgtar --decrypt --directory ~/.ssh ./backup/ssh.gpgtar
}

# restore_homebrew && \
# restore_nvm && \
restore_pnupg && \
restore_secrets
