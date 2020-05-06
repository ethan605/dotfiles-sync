" Plugins management with VimPlug: https://github.com/junegunn/vim-plug
call plug#begin()

Plug '/usr/local/bin/fzf'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'alampros/vim-styled-jsx'
Plug 'andreshazard/vim-freemarker'
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mkitt/tabline.vim'
Plug 'niftylettuce/vim-jinja'
Plug 'pangloss/vim-javascript'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdTree'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" For vim-airline
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

" For indentLine
let g:indentLine_char = '│'
let g:indentLine_conceallevel = '0'

" For NERDTree
let g:NERDSpaceDelims = 1 
let g:NERDTreeIgnore = ['\~$', 'vendor', 'node_modules']

" For Prettier
let g:prettier#autoformat = 0

" For material-monokai
let g:materialmonokai_italic=1
let g:materialmonokai_subtle_airline=1
let g:materialmonokai_subtle_spell=1

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

set autoread                " Auto reload file from outside changes
set autowrite               " Auto reload file from outside changes
set background=dark         " For dark themes
set clipboard+=unnamed      " Use system clipboard over vim's buffers
set cmdheight=2             " Better display for messages
set directory=/tmp          " Location for temporary files
set encoding=UTF-8          " Encoding
set expandtab               " Insert spaces when TAB is pressed.
set formatoptions+=o        " Continue comment marker in new lines.
set ignorecase              " Search with smart case
set linespace=0             " Set line-spacing to minimum.
set modeline                " Enable modeline.
set nobackup                " Some LSP servers have issues with backup files
set noerrorbells            " No beeps.
set nofoldenable				    " Not folding by default
set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
set nostartofline           " Do not jump to first character with page commands.
set noswapfile              " Disable swap files
set nowritebackup           " Some LSP servers have issues with backup files
set number relativenumber   " Show hybrid line numbers on the left side.
set ruler                   " Show the line and column numbers of the cursor.
set scrolloff=3             " Show next 3 lines while scrolling.
set shiftwidth=2            " Indentation amount for < and > commands.
set shortmess+=c            " don't give 'ins-completion-menu' messages.
set showcmd                 " Show (partial) command in status line.
set showmatch               " Show matching brackets.
set showmode                " Show current mode.
set sidescrolloff=5         " Show next 5 columns while side-scrolling.
set signcolumn=yes          " always show signcolumns
set smartcase               " Search with smart case
set splitbelow              " Horizontal split below current.
set splitright              " Vertical split to right of current.
set tabstop=2               " Render TABs using this many spaces.
set textwidth=0             " Hard-wrap long lines as you type them.
set updatetime=300          " You will have bad experience for diagnostic messages when it's default 4000.

" Configure backups
set backupcopy=yes
set backupdir=~/tmp,/tmp
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

" Configure code folding
" set conceallevel=0        " Disable markdown conceal
" set foldlevel=2					  " Fold level
" set foldmethod=indent     " Code folding by indents
" set foldnestmax=10			  " Max nesting for code folding

" Configure special characters
set t_ZH=[3m
set t_ZR=[23m

" Configure fzf
set rtp+=/usr/local/opt/fzf 

" Color scheme
syntax on

" Custom functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:smarter_NERDTreeToggle()
  if &filetype == 'nerdtree'
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction

" Line limit column colors
" hi ColorColumn      ctermbg=red           ctermfg=fg 

" Matched parentheses colors
hi MatchParen       cterm=bold            ctermbg=none      ctermfg=red

" TabLine highlight colors
hi TabLine          cterm=none            ctermbg=none        ctermfg=white
hi TabLineFill      cterm=none            ctermbg=none
hi TabLineSel       cterm=bold,inverse

hi SpellBad         cterm=undercurl       ctermbg=none      ctermfg=lightred
hi SpellCap         cterm=undercurl       ctermbg=none      ctermfg=lightred
hi SpellLocal       cterm=undercurl       ctermbg=none      ctermfg=lightred
hi SpellRare        cterm=undercurl       ctermbg=none      ctermfg=lightred

" Toggle NERDTree with focusing current file's location
nmap <silent> <c-o> :call <sid>smarter_NERDTreeToggle()<cr>

" Quick files opening
nmap <silent> <c-p> :GFiles<cr>
nmap <silent> <c-g> :GFiles?<cr>

" Search globally with RipGrep
nmap <c-s> :Rg<space>

" Copy current file's path
nmap <silent> ycf :let @+=@%<cr>

" Easymotion prefix
nmap <silent> <leader> <Plug>(easymotion-prefix)

" Leader + space to hide search highlights
nmap <silent> <leader><space> :nohlsearch<cr>

" Show a mark for characters at column 120
call matchadd('ColorColumn', '\%120v', 100)

filetype plugin on

" Autofix for Prettier on save
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

augroup javascript_folding
  au!
  au FileType javascript setlocal foldmethod=syntax
augroup END

