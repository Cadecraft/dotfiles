# init.vim for Cadecraft
# R: v0.1.0, E: 2024/07/06

:exe 'edit '.stdpath('config').'/init.vim'
:write ++p

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/vimfiles/vimrc

" Neovide GUI configuration
if exists("g:neovide")
	" Font
	set guifont=Consolas:h11:cANSI
	let g:neovide_position_animation_length = 0.1
	let g:neovide_scroll_animation_length = 0.2
endif
