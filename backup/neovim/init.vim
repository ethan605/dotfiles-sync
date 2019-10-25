" Plugins management with VimPlug: https://github.com/junegunn/vim-plug
call plug#begin()

Plug '/usr/local/bin/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'kaicataldo/material.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'mkitt/tabline.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'skielbasa/vim-material-monokai'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:smarter_NERDTreeToggle()
  if &filetype == 'nerdtree'
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction

" For vim-airline
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

" For ALE
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" For NERDTree
let g:NERDSpaceDelims = 1 
let g:NERDTreeIgnore = ['\~$', 'vendor', 'node_modules']

" Auto format for Prettier
let g:prettier#autoformat = 0

" For material-monokai
let g:materialmonokai_italic=1
let g:materialmonokai_subtle_airline=1
let g:materialmonokai_subtle_spell=1

" set foldlevel=2					" Fold level
" set foldmethod=indent   " Code folding by indents
" set foldnestmax=10			" Max nesting for code folding
" set nofoldenable				" Not folding by default
" set paste               " Paste from a windows or from vim
set background=dark     " For dark themes
set clipboard+=unnamed  " Use system clipboard over vim's buffers
set cmdheight=2         " Better display for messages
set encoding=UTF-8      " Encoding
set expandtab           " Insert spaces when TAB is pressed.
set formatoptions+=o    " Continue comment marker in new lines.
set linespace=0         " Set line-spacing to minimum.
set modeline            " Enable modeline.
set nobackup            " Some servers have issues with backup files
set nowritebackup       " Some servers have issues with backup files
set noerrorbells        " No beeps.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set nostartofline       " Do not jump to first character with page commands.
set number              " Show the line numbers on the left side.
set ruler               " Show the line and column numbers of the cursor.
set scrolloff=3         " Show next 3 lines while scrolling.
set shiftwidth=2        " Indentation amount for < and > commands.
set shortmess+=c        " don't give 'ins-completion-menu' messages.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set sidescrolloff=5     " Show next 5 columns while side-scrolling.
set signcolumn=yes      " always show signcolumns
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set tabstop=2           " Render TABs using this many spaces.
set textwidth=0         " Hard-wrap long lines as you type them.
set updatetime=300      " You will have bad experience for diagnostic messages when it's default 4000.

" For fzf
set rtp+=/usr/local/opt/fzf 

" Color scheme
syntax on
colorscheme material-monokai
" colorscheme material

" ALE highlight colors
hi ALEError         ctermbg=NONE    cterm=undercurl
hi ALEWarning       ctermbg=NONE    cterm=undercurl
hi ALEErrorSign     ctermbg=NONE    cterm=NONE
hi ALEWarningSign   ctermbg=NONE    cterm=NONE

" Search highlight colors
hi ColorColumn      ctermfg=White   ctermbg=Red
hi Search           ctermfg=White   ctermbg=DarkMagenta

" TabLine highlight colors
hi TabLine          ctermfg=White   ctermbg=Black       
hi TabLineFill      ctermfg=White   ctermbg=Black       
hi TabLineSel       ctermfg=White   ctermbg=DarkBlue    

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <C-c> to trigger completion.
inoremap <silent><expr> <C-c> coc#refresh()

" Use <C-space> to confirm completion
inoremap <expr> <C-space> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" coc.nvim gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Multiple cursors
nmap <expr><silent> <C-d> <SID>select_current_word()

" Toggle NERDTree with focusing current file's location
nmap <silent> <C-o> :call <SID>smarter_NERDTreeToggle()<CR>

" Open Git included files
nmap <C-p> :GFiles<CR>

" Search globally with RipGrep
nmap <C-s> :Rg<space>

" Copy current file's path
nmap ycf :let @+=@%<CR>

" Easymotion prefix
nmap <Leader> <Plug>(easymotion-prefix)

" Show a mark for characters at column 120
call matchadd('ColorColumn', '\%120v', 100)

filetype plugin on

" Autofix for Prettier on save
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

" Auto start Terminal mode when open Terminal
autocmd TermOpen * startinsert
