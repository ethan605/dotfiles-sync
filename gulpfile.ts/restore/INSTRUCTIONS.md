# Instructions to restore

Manual instructions to restore dotfiles, automation is under WIP

### 1. Alacritty

##### Files map

- `backup/alacrity/alacritty.yml` => `~/.config/alacritty/alacritty.yml`

##### After restore

- Restart Alacritty

### 2. Homebrew

WIP

### 3. Git

##### Files map

- `backup/git/.gitconfig` => `~/.gitconfig`

### 4. GnuPG

##### Files map

- `backup/gnupg/*.conf` => `~/gnupg/*.conf`

### 5. Karabiner

##### Files map

- `backup/karabiner/**/*.json` => `~/.config/karabiner/**/*.json`

### 6. Kitty

##### Files map

- `backup/kitty/**/*.conf` => `~/.config/kitty/**/*.conf`

##### After restore

- Restart Kitty

### 7. Neovim

##### Files map

- `backup/neovim/init.vit` => `~/.config/nvim/init.nvim`
- `backup/neovim/coc-extensions.json` => `~/.config/coc/extensions/package.json`

##### After restore

- Restart Neovim
- Run this in Command mode: `:PlugInstall`

### 8. Oh-my-zsh

##### Files map

- `backup/oh-my-zsh/.zshrc` => `~/.zshrc`

##### After restore

- Run this in terminal: `source ~/.zshrc`

### 9. Tmux

##### Files map

- `backup/tmux/.tmux.conf` => `~/.tmux.conf`
- `backup/tmux/.tmux.conf.local` => `~/.tmux.conf.local`

##### After restore

- Kill all Tmux sessions and start over

### 10. Vim

##### Files map

- `backup/vim/.vimrc` => `~/.vimrc`

##### After restore

- Restart Vim
- Run this in Command mode: `:PlugInstall`

### 11. Visual Studio Code

WIP