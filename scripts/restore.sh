#!/bin/bash
source scripts/helpers.sh

NODE_VERSION=v12.16
BREW_CONTENT_URL=https://raw.githubusercontent.com/Homebrew/install/master
TEMP_DIR=/tmp/ethan605/dotfiles

clean_up() {
  rm -rf $TEMP_DIR
  print_step "Clean up temp dir"
}

prepare() {
  rm -rf $TEMP_DIR
  mkdir -p $TEMP_DIR
}

brew_restore_taps() {
  print_sub_step "Taps"
  for tap in $(read_remote_json_array brew/taps); do
    brew tap $tap
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
    nvm install $version
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

restore_secret_source() {
  local dest="$HOME/.$1"
  local source="$1.gpgtar"

  mkdir -p $dest && \
  curl -o $TEMP_DIR/$source -fsSL $BACKUP_CONTENT_URL/$source && \
  gpgtar --decrypt --directory $dest $TEMP_DIR/$source
}

restore_secrets() {
  print_step "Restore secret sources"

  print_sub_step "Gradle"
  restore_secret_source gradle

  print_sub_step "SSH keys"
  restore_secret_source ssh
}

download_and_unzip() {
  local source="$1.zip"
  curl -o $TEMP_DIR/$source -fsSL $BACKUP_CONTENT_URL/$source && \
  unzip -q -d $TEMP_DIR $TEMP_DIR/$source
}

restore_fonts() {
  print_step "Restore fonts"

  print_sub_step "Operator Mono Lig"
  download_and_unzip operatorMonoLig
  cp $TEMP_DIR/operatorMonoLig/* $HOME/Library/Fonts
}

trap clean_up EXIT

prepare && \
restore_homebrew && \
restore_nvm && \
restore_pnupg && \
restore_secrets && \
restore_fonts
