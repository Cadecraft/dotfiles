" gvimrc for Cadecraft
" R: v0.3.3, E: 2026/08/16

" Appearance: no menu, no scrollbars, console-style tabs
set guioptions=d
" Font varies on OS (Windows has a bad time rendering Inconsolata)
if has('win32')
	set guifont=Consolas:h11:cANSI
else
	" Also an option: Consolas\ NF\ 11
	set guifont=Inconsolata\ Nerd\ Font\ Regular\ 12
endif
