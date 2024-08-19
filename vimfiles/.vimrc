" Vimrc for Cadecraft
" R: v0.3.6, E: 2024/08/19

" Simple
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

" Location for swap files (the tmp folder must be created)
" The double slashes ensures the file is always unique
set backupdir=$HOME/.tmp//
set directory=$HOME/.tmp//

" Appearance: preferences
set number
set cursorline

" Editing: preferences
set clipboard=unnamed
set so=8
set backspace=indent,eol
" Disable auto comment next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" To switch buffers
set hidden

" Editing: remaps
nnoremap <SPACE> <Nop>
let mapleader = " "
inoremap jk <Esc>
inoremap <C-BS> <C-w>
vnoremap <Leader>p "_dP
" Strikethrough in markdown lists
nnoremap <Leader>s _wi~~<Esc>A~~<Esc>0
nnoremap <Leader>S _f~xxf~xx0
" Window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> :redraw!<cr><C-w>l

" Editing: custom commands
:command Use4Space set ts=4 sw=4 expandtab
:command Use8Tab set ts=8 sw=8 noexpandtab
:command WritingMode set background=light breakindent linebreak
:command HideBackground hi Normal guibg=NONE ctermbg=NONE

" Plugins: install using vim-plug (requires `plug.vim` from `junegunn/vim-plug` to be in the autoload directory)
call plug#begin()
" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Misc.
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
" Themes
Plug 'cocopon/iceberg.vim'
Plug 'embark-theme/vim'
call plug#end()

" Plugins: preferences/config
let g:NERDTreeChDirMode=2

" Appearance: colors
" `t_Co=256` should not be needed
set termguicolors
set background=dark
" Use iceberg, with sorbet as a built-in backup
colorscheme sorbet
colorscheme iceberg
