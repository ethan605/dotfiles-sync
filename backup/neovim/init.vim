" Plugins management with VimPlug: https://github.com/junegunn/vim-plug
call plug#begin()

Plug '/usr/local/bin/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mattn/emmet-vim'
Plug 'mkitt/tabline.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'skielbasa/vim-material-monokai'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'

call plug#end()

" For vim-airline
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 0

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

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" set foldlevel=2					  " Fold level
" set foldmethod=indent     " Code folding by indents
" set foldnestmax=10			  " Max nesting for code folding
" set paste                 " Paste from a windows or from vim
set autoread                " Auto reload file from outside changes
set autowrite               " Auto reload file from outside changes
set background=dark         " For dark themes
set clipboard+=unnamed    " Use system clipboard over vim's buffers
set cmdheight=2           " Better display for messages
set directory=/tmp        " Location for temporary files
set encoding=UTF-8        " Encoding
set expandtab             " Insert spaces when TAB is pressed.
set formatoptions+=o      " Continue comment marker in new lines.
set ignorecase            " Search with smart case
set linespace=0           " Set line-spacing to minimum.
set modeline              " Enable modeline.
set nobackup              " Some LSP servers have issues with backup files
set noerrorbells          " No beeps.
set nofoldenable				  " Not folding by default
set nojoinspaces          " Prevents inserting two spaces after punctuation on a join (J)
set nostartofline         " Do not jump to first character with page commands.
set noswapfile            " Disable swap files
set nowritebackup         " Some LSP servers have issues with backup files
set number relativenumber " Show hybrid line numbers on the left side.
set ruler                 " Show the line and column numbers of the cursor.
set scrolloff=3           " Show next 3 lines while scrolling.
set shiftwidth=2          " Indentation amount for < and > commands.
set shortmess+=c          " don't give 'ins-completion-menu' messages.
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
set showmode              " Show current mode.
set sidescrolloff=5       " Show next 5 columns while side-scrolling.
set signcolumn=yes        " always show signcolumns
set smartcase             " Search with smart case
set splitbelow            " Horizontal split below current.
set splitright            " Vertical split to right of current.
set tabstop=2             " Render TABs using this many spaces.
set textwidth=0           " Hard-wrap long lines as you type them.
set updatetime=300        " You will have bad experience for diagnostic messages when it's default 4000.

" Configure backups
set backupcopy=yes
set backupdir=~/tmp,/tmp
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

" Configure fzf
set rtp+=/usr/local/opt/fzf 

" Color scheme
syntax on
colorscheme material-monokai

" Custom functions
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

" ALE highlight colors
hi ALEError         ctermbg=NONE          cterm=undercurl
hi ALEWarning       ctermbg=NONE          cterm=undercurl
hi ALEErrorSign     ctermbg=NONE          cterm=NONE
hi ALEWarningSign   ctermbg=NONE          cterm=NONE

" Line limit column colors
hi ColorColumn      ctermbg=Red           ctermfg=White 

" Search highlight colors
hi Search           ctermbg=DarkYellow    ctermfg=White 

" Line numbers colors
hi LineNr           ctermfg=DarkGrey
hi CursorLineNr     ctermfg=White         ctermbg=bg

" TabLine highlight colors
hi TabLine          cterm=NONE            ctermbg=bg    ctermfg=White
hi TabLineFill      cterm=NONE
hi TabLineSel       cterm=BOLD,INVERSE

" Visual selection colors
hi Visual           ctermfg=White

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
" nmap <expr><silent> <C-d> <SID>select_current_word()

" Toggle NERDTree with focusing current file's location
nmap <silent> <C-o> :call <SID>smarter_NERDTreeToggle()<CR>

" Quick files opening
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

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END
