" First install VimPlug: https://github.com/junegunn/vim-plug
call plug#begin()

Plug '/usr/local/bin/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

let g:vim_markdown_folding_disabled = 1
let g:ctrlp_show_hidden = 1
let g:NERDTreeIgnore = ['\~$', 'vendor', 'node_modules']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|node_modules|\.sass-cache|bower_components|build)$' 
  \ }

set clipboard=unnamed   " Use system clipboard over vim's buffers
set encoding=UTF-8
set expandtab           " Insert spaces when TAB is pressed.
set formatoptions+=o    " Continue comment marker in new lines.
set linespace=0         " Set line-spacing to minimum.
set modeline            " Enable modeline.
set noerrorbells        " No beeps.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set nostartofline       " Do not jump to first character with page commands.
set number              " Show the line numbers on the left side.
set ruler               " Show the line and column numbers of the cursor.
set shiftwidth=2        " Indentation amount for < and > commands.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode. set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set tabstop=2           " Render TABs using this many spaces.
set textwidth=0         " Hard-wrap long lines as you type them.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif

if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" For fzf
set rtp+=/usr/local/opt/fzf

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc.nvim gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <C-y><C-f> :let @+=@%<CR>
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)

filetype plugin on
autocmd BufWritePre *.js Neoformat
