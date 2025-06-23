" Vimrc for Cadecraft
" R: v0.5.0, E: 2025/06/23

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
" Selection utilities for misc. personal use
nnoremap <Leader>v ^vg_
nnoremap <Leader>ma ?* <CR>wvg_
" Window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> :redraw!<cr><C-w>l
" Indentation options (ex. `<Leader>i2s` => sets indentation to 2 spaces)
for use_spaces in [0, 1]
	for indent_size in range(2, 9, 2)
		execute join([
			\"nnoremap <Leader>i",
			\indent_size,
			\(use_spaces ? "s" : "t"),
			\" :set ts=",
			\indent_size,
			\" sw=",
			\indent_size,
			\" ",
			\(use_spaces ? "expandtab" : "noexpandtab"),
			\"<CR>"
		\], "")
	endfor
endfor

" Editing: custom commands
:command Cdcurr cd %:p:h
:command WritingMode set background=light breakindent linebreak
function ListModeFunction()
	" List Mode makes editing large, formatted personal text files more ergonomic
	" Note: this function needs only exist in this vimrc; List Mode is generally not meant to be used in Neovim
	set breakindent linebreak ts=4 sw=4 noexpandtab display+=lastline autoindent ignorecase so=8
	if has("gui_running")
		" In gvim, decrease the font size and increase the window size
		set guifont=Consolas:h10:cANSI
		set lines=30
		set columns=100
		winpos 800 400
	endif
endfunction
:command ListMode call ListModeFunction()
:command MoveGvim if has("gui_running") | winpos 800 400 | endif
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
Plug 'tpope/vim-surround'
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
