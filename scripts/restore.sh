#!/bin/bash
source scripts/helpers.sh

PATH=/usr/bin:/usr/local/bin:$PATH
NODE_VERSION=v12.16

prepare() {
  print_step "Prepare resources"

  rm -rf $TEMP_DIR
  mkdir -p $TEMP_DIR

  if [ ! $(command -v brew) ]; then
    sh -c "$(curl -fsSL $GITHUB_CONTENT_URL/Homebrew/install/master/install.sh)"
  fi

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL $GITHUB_CONTENT_URL/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
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

restore_gnupg() {
  print_step "Restore GnuPG"

  gpg --import /Volumes/Keybase/private/ethan605/.keys/pgp/9d5aa3a830b5e5a7f30cea889c6ceb919ed2cefe.asc && \
  gpg --edit-key thanhnx.605@gmail.com && \
  cp ./backup/gnupg/*.conf $HOME/.gnupg && \
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
  chmod a=-,u=r $HOME/.ssh/*_rsa
  chmod a=-,u=r $HOME/.ssh/*_rsa
}

restore_fonts() {
  print_step "Restore fonts"

  print_sub_step "Operator Mono Lig"
  download_and_unzip fonts operatorMonoLig $HOME/Library/Fonts
}

restore_neovim() {
  local coc_dir="$HOME/.config/coc/extensions"

  mkdir -p $HOME/.config/nvim && \
  download_and_restore_file neovim/init.vim $HOME/.config/nvim/init.vim && \
  nvim -c 'PlugInstall | qa' && \
  mkdir -p $coc_dir && \
  download_and_restore_file neovim/coc-extensions.json $coc_dir/package.json && \
  cd $coc_dir && \
  npm install --no-package-lock
}

restore_vscode() {
  local vscode_user_dir="$HOME/Library/Application Support/Code/User"

  mkdir -p $vscode_user_dir && \
  download_and_restore_file vscode/settings.json $TEMP_DIR/vscode-settings.json && \
  mv $TEMP_DIR/vscode-settings.json "$vscode_user_dir/settings.json"

  for extension in $(read_remote_json_array vscode/extensions); do
    code --install-extension $extension
  done
}

restore_files_directly() {
  print_step "Restore files directly"

  print_sub_step "Alacritty"
  mkdir -p $HOME/.config/alacritty && \
  download_and_restore_file alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

  print_sub_step "Git"
  download_and_restore_file git/.gitconfig $HOME/.gitconfig

  print_sub_step "Karabiner"
  mkdir -p $HOME/.config/karabiner && \
  download_and_restore_file karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

  print_sub_step "Kitty"
  mkdir -p $HOME/.config/kitty/colorschemes && \
  download_and_restore_file kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  download_and_unzip kitty colorschemes $HOME/.config/kitty/colorschemes

  print_sub_step "Neovim"
  restore_neovim

  print_sub_step "Oh-my-zsh"
  download_and_restore_file oh-my-zsh/.zshrc $HOME/.zshrc && \
  /bin/zsh -c "PREFIX='' source $HOME/.zshrc"

  print_sub_step "Tmux"
  download_and_restore_file tmux/.tmux.conf $HOME/.tmux.conf
  download_and_restore_file "tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

  print_sub_step "Vim"
  download_and_restore_file vim/.vimrc $HOME/.vimrc
  
  print_sub_step "VSCode"
  restore_vscode
}

trap clean_up EXIT

prepare && \
restore_homebrew && \
restore_nvm && \
restore_gnupg && \
restore_secrets && \
restore_fonts && \
restore_files_directly
