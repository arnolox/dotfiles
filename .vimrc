"       _   __(_)___ ___        _________  ____  / __(_)___ _
"      | | / / / __ `__ \______/ ___/ __ \/ __ \/ /_/ / __ `/
"      | |/ / / / / / / /_____/ /__/ /_/ / / / / __/ / /_/ /
"      |___/_/_/ /_/ /_/      \___/\____/_/ /_/_/ /_/\__, /
"                                                   /____/
"------------------------------------------------------------------------------
" GENERAL
"------------------------------------------------------------------------------
set encoding=utf-8            " Ensure encoding is UTF-8
set nocompatible              " Disable Vi compatability

"------------------------------------------------------------------------------
" VUNDLE CONFIG
"------------------------------------------------------------------------------
filetype off
set rtp+=~/.vim/bundle/vundle " Set the runtime path to include Vundle
call vundle#begin()           " Initialize vundle

" General plugins
Plugin 'gmarik/vundle'                    " Let Vundle manage Vundle
Plugin 'ctrlpvim/ctrlp.vim'               " Quick file navigation
Plugin 'jceb/vim-orgmode'                 " Emacs org-mode in vim
Plugin 'godlygeek/tabular'                " Tabular character alignment
Plugin 'vim-scripts/a.vim'                " Switch between source and header
Plugin 'luochen1990/rainbow'              " Rainbow parentheses
Plugin 'kopischke/vim-stay'               " Keep cursor position between sessions
Plugin 'airblade/vim-gitgutter'           " Show git changes in gutter
Plugin 'plasticboy/vim-markdown'          " Markdown syntax highlighting
Plugin 'scrooloose/nerdcommenter'         " Easy commenting
Plugin 'ludovicchabant/vim-gutentags'     " Tag file management
Plugin 'octol/vim-cpp-enhanced-highlight' " Better C++ highlights

" Colorschemes
Plugin 'chriskempson/base16-vim' " base16 colorschemes

" Tab/bufferline
Plugin 'vim-airline/vim-airline'        " Nicer tab/status line at bottom
Plugin 'vim-airline/vim-airline-themes' " Themes for vim-airline

" tpope
Plugin 'tpope/vim-fugitive' " Help formatting commit messages
Plugin 'tpope/vim-endwise'  " Automatically add 'end' constructs
Plugin 'tpope/vim-abolish'  " Easily work with multiple variants of a word
Plugin 'tpope/vim-sensible' " Sane defaults

call vundle#end() " Complete vundle initialization

filetype plugin indent on " enable filetype and indent detection


" ------------------------------------------------------------------------------
" APPEARANCE
" ------------------------------------------------------------------------------
syntax on                           " enable syntax highlighting
set background=dark                 " assume a dark background
set ruler                           " show ruler in lower right
set number                          " show line numbers
set nowrap                          " disable line wraping
set hlsearch                        " highlight all search results
set list listchars=tab:▸\ ,trail:· " display tabs and trailing spaces
" let loaded_matchparen=1           " turn off match paren highlighting


"------------------------------------------------------------------------------
" THEMING
"------------------------------------------------------------------------------
" set termguicolors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


"------------------------------------------------------------------------------
" BEHAVIOUR
"------------------------------------------------------------------------------
" autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
" autocmd BufLeave * silent! wall    " save on lost focus

set diffopt += vertical         " Use vertical splits for diffs
set wildmenu                    " show possible completions on command line
set splitbelow                  " split panes on the bottom
set splitright                  " split panes to the right
set ttyfast                     " Send more characters for redraws
set backupdir=$HOME/.vim/backup " Redirect backups
set directory=$HOME/.vim/swap   " Redirect swaps
set virtualedit=onemore         " Allow cursor to move past the last character of a line
set autoread                    " Reload externally-updated files without prompt
set gdefault                    " Replace all occurences by default in find/replace

" Enable mouse use
set mouse=a
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end


" Persistent undo
set undofile
set undolevels=1000
set undoreload=10000
set undodir=$HOME/.vim/undo


"------------------------------------------------------------------------------
" GENERAL MAPPINGS
"------------------------------------------------------------------------------
" Always show taglist
nnoremap <C-]> g]

" Yank to end of line
nnoremap Y y$

" Sane shifting
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Strip trailing whitespace with F5
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"------------------------------------------------------------------------------
" TABS & SPACES
"------------------------------------------------------------------------------
set shiftwidth=4               " assume 4 spaces for a tab
set expandtab                  " expand those tabs to spaces
set tabstop=4                  " number of spaces a tab counts for in file
set softtabstop=4              " number of spaces a tab counts for editing
set smarttab                   " translate tabs into shiftwidth worth of spaces


"------------------------------------------------------------------------------
" LEADER SHORTCUTS
"------------------------------------------------------------------------------
let mapleader = "," " Use better map leader

" quickly Open vimrc
nmap <silent> <leader>ev :edit $MYVIMRC<CR>
" load vimrc into memory
nmap <silent> <leader>ee :source $MYVIMRC<CR>

map <leader>x :let &background = ( &background == "dark"? "light" : "dark" )<CR>


"------------------------------------------------------------------------------
" TABS, SPLITS & PANES
"------------------------------------------------------------------------------
" easy tab management
map <leader>tn :tabnew<CR>
nmap H :tabprevious<CR>
nmap L :tabnext<CR>

" change windows easily with hjkl
imap <C-h> <C-o><C-w>h
imap <C-j> <C-o><C-w>j
imap <C-k> <C-o><C-w>k
imap <C-l> <C-o><C-w>l

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" create splits
map <leader>v :vsplit<CR>
map <leader>p :split<CR>


"------------------------------------------------------------------------------
" AIRLINE
"------------------------------------------------------------------------------
let g:airline_theme = 'dark-minimal' " set vim-airline theme
let g:airline_section_c = '' " Empty the bufferline section for narrow splits
let g:airline_extensions = [] " only load these extensions
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1 " cache syntax highlighting groups
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tablein#formatter = 'unique_tail' " set tabline path format


"------------------------------------------------------------------------------
" TABULAR
"------------------------------------------------------------------------------
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a# :Tabularize /#<CR>
vmap <Leader>a# :Tabularize /#<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>


"------------------------------------------------------------------------------
" A.VIM
"------------------------------------------------------------------------------
nnoremap <Leader>h  :A <CR> " In place
nnoremap <Leader>ht :AT<CR> " Tab
nnoremap <Leader>hn :AN<CR> " Cycle through matches 
nnoremap <Leader>hv :AV<CR> " Vertical split
nnoremap <Leader>hs :AS<CR> " Horizontal Split


"------------------------------------------------------------------------------
" CTRL-P CONFIG
"------------------------------------------------------------------------------
" ignore anything not tracked by git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1          " include hidden files in results
let g:ctrlp_custom_ignore = { 'dir': 'build$\|.*rjquote.*', 'file': '\.pyc$' }
" let g:ctrlp_working_path_mode = '' " stop setting git repo as root path


"------------------------------------------------------------------------------
" RAINBOW PARENTHESES
"------------------------------------------------------------------------------

