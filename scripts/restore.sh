#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset

readonly GITHUB_CONTENT_URL="https://raw.githubusercontent.com"
readonly BACKUP_CONTENT_URL="$GITHUB_CONTENT_URL/ethan605/dotfiles/master/backup"
readonly JOB_ID="ethanify.dotfiles.backup"
readonly NODE_VERSION="v12.16"
readonly TEMP_DIR="/tmp/$JOB_ID"

PATH="/usr/bin:/usr/local/bin:$PATH"
unset PREFIX

function clean_up() {
  print_step "Clean up temp files"
  rm -rf $TEMP_DIR
}

function prepare() {
  mkdir -p $TEMP_DIR

  curl --output $TEMP_DIR/helpers.sh -fsSL $GITHUB_CONTENT_URL/ethan605/dotfiles/master/scripts/helpers.sh
  source $TEMP_DIR/helpers.sh

  print_step "Prepare resources"

  if [[ ! $(command -v brew) ]]; then
    sh -c "$(curl -fsSL $GITHUB_CONTENT_URL/Homebrew/install/master/install.sh)"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL $GITHUB_CONTENT_URL/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
}

function download_and_restore_file() {
  local source="$1"
  local dest="$2"
  curl -o $dest -fsSL $BACKUP_CONTENT_URL/$source
}

function download_and_unzip() {
  local srcDir="$1"
  local srcFile="$2"
  local dest="$3"

  mkdir -p $TEMP_DIR/$srcDir
  curl -o $TEMP_DIR/$srcDir/$srcFile.zip -fsSL $BACKUP_CONTENT_URL/$srcDir/$srcFile.zip
  unzip -q -d $TEMP_DIR/$srcDir $TEMP_DIR/$srcDir/$srcFile.zip
  cp $TEMP_DIR/$srcDir/$srcFile/* $dest
}

function read_remote_json_array() {
  local source="$1"
  curl -fsSL $BACKUP_CONTENT_URL/$source.json | jq -r '.[]'
}

function brew_restore_taps() {
  print_sub_step "Taps"
  for tap in $(read_remote_json_array brew/taps); do
    brew tap $tap
  done
}

function brew_restore_formulaes() {
  print_sub_step "Formulaes"
  brew install $(read_remote_json_array brew/formulaes)
}

function brew_restore_casks() {
  print_sub_step "Casks"
  brew cask install $(read_remote_json_array brew/casks)
}

function restore_homebrew() {
  print_step "Restore Homebrew"

  brew install jq
  brew_restore_taps
  brew_restore_formulaes
  brew_restore_casks
}

function nvm_restore_node_versions() {
  print_sub_step "Node versions"

  for version in $(read_remote_json_array nvm/nodeVersions); do
    nvm install $version
  done
}

function nvm_restore_global_npm_packages() {
  print_sub_step "Global NPM packages"
  npm install --global $(read_remote_json_array nvm/globalNpmPackages)
}

function restore_nvm() {
  print_step "Restore NVM"

  brew install nvm
  local nvm_dir=$(brew --prefix nvm)

  source $nvm_dir/nvm.sh
  nvm_restore_node_versions
  nvm alias node $NODE_VERSION
  nvm alias default node
  nvm use --default --delete-prefix node
  npm config set prefix "$nvm_dir/versions/node/$(nvm version node)"
  nvm_restore_global_npm_packages
}

function restore_rvm() {
  print_step "Restore RVM"

  gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
  rvm install 2.7
}

function restore_gnupg() {
  print_step "Restore GnuPG"

  gpg --import ~/Downloads/ethan605.asc
  gpg --edit-key thanhnx.605@gmail.com
  download_and_restore_file gnupg/gpg.conf $HOME/.gnupg/gpg.conf
  download_and_restore_file gnupg/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
  killall gpg-agent
  gpg-agent --daemon
  echo "test" | gpg --clearsign &> /dev/null
}

function restore_secret_source() {
  local dest="$HOME/.$1"
  local source="$1.gpgtar"

  mkdir -p $dest
  curl -o $TEMP_DIR/$source -fsSL $BACKUP_CONTENT_URL/$source
  gpgtar --decrypt --directory $dest $TEMP_DIR/$source
}

function restore_secrets() {
  print_step "Restore secret sources"

  print_sub_step "Gradle"
  restore_secret_source gradle

  print_sub_step "SSH keys"
  restore_secret_source ssh
  chmod a=-,u=r $HOME/.ssh/id_*
}

function restore_fonts() {
  print_step "Restore fonts"

  print_sub_step "Operator Mono Lig"
  download_and_unzip fonts operatorMonoLig $HOME/Library/Fonts
}

function restore_neovim() {
  local coc_dir="$HOME/.config/coc/extensions"

  curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    $GITHUB_CONTENT_URL/junegunn/vim-plug/master/plug.vim

  mkdir -p $HOME/.config/nvim
  download_and_restore_file neovim/init.vim $HOME/.config/nvim/init.vim
  nvim --headless +PlugInstall +qa
  mkdir -p $coc_dir
  download_and_restore_file neovim/coc-extensions.json $coc_dir/package.json
  cd $coc_dir
  npm install --no-package-lock
}

function restore_qmk() {
  local qmk_dir="$HOME/Library/Application Support/qmk"
  mkdir -p "$qmk_dir"
  download_and_restore_file qmk/qmk.ini $TEMP_DIR/qmk.ini
  mv $TEMP_DIR/qmk.ini "$qmk_dir/qmk.ini"
}

function restore_vscode() {
  local vscode_user_dir="$HOME/Library/Application Support/Code/User"

  mkdir -p $vscode_user_dir
  download_and_restore_file vscode/settings.json $TEMP_DIR/vscode-settings.json
  mv $TEMP_DIR/vscode-settings.json "$vscode_user_dir/settings.json"

  for extension in $(read_remote_json_array vscode/extensions); do
    code --install-extension $extension
  done
}

function restore_files_directly() {
  print_step "Restore files directly"

  print_sub_step "Alacritty"
  mkdir -p $HOME/.config/alacritty
  download_and_restore_file alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

  print_sub_step "Git"
  download_and_restore_file git/.gitconfig $HOME/.gitconfig

  print_sub_step "Karabiner"
  mkdir -p $HOME/.config/karabiner
  download_and_restore_file karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

  print_sub_step "Kitty"
  mkdir -p $HOME/.config/kitty/colorschemes
  download_and_restore_file kitty/kitty.conf $HOME/.config/kitty/kitty.conf
  download_and_unzip kitty colorschemes $HOME/.config/kitty/colorschemes

  print_sub_step "Neovim"
  restore_neovim

  print_sub_step "Qmk"
  restore_qmk

  print_sub_step "Tmux"
  download_and_restore_file tmux/.tmux.conf $HOME/.tmux.conf
  download_and_restore_file "tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

  print_sub_step "Vifm"
  download_and_restore_file vifm/vifmrc $HOME/.config/vifm/vifmrc

  print_sub_step "Vim"
  download_and_restore_file vim/.vimrc $HOME/.vimrc

  print_sub_step "Zsh"
  download_and_restore_file zsh/.zshrc $HOME/.zshrc
  
  # print_sub_step "VSCode"
  # restore_vscode

  print_sub_step "Launchctl"
  download_and_restore_file launchctl/$JOB_ID.plist $HOME/Library/LaunchAgents/$JOB_ID.plist
}

function restore() {
  prepare && \
  restore_homebrew && \
  restore_nvm && \
  restore_rvm && \
  restore_gnupg && \
  restore_secrets && \
  restore_fonts && \
  restore_files_directly
}

trap clean_up EXIT
restore
