-- init.lua for Cadecraft
-- R: v0.6.2, E: 2024/09/08

-- This file also contains the translated contents of my vimrc from regular Vim, so it can be used by itself without a vimrc dependency

-- By default, filetype, plugin, indent, and syntax on are enabled

-- Location for swap files (the tmp folder must be created)
local prefix = vim.fn.expand('~/.nvim')
vim.opt.backupdir = { prefix .. '/.tmp//' }
vim.opt.directory = { prefix .. '/.tmp//' }

-- Use PowerShell in Windows
if vim.fn.has('macunix') == 0 then
	vim.o.shell = "powershell.exe"
	vim.o.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
	vim.o.shellxquote = ''
end

-- Appearance: preferences
vim.opt.number = true
vim.opt.cursorline = true

-- Editing: preferences
vim.opt.clipboard = 'unnamed'
vim.opt.so = 8
vim.opt.backspace = { 'indent', 'eol' }
-- Disable auto-commenting the next line
vim.api.nvim_create_autocmd('BufEnter', {
	callback = function()
		vim.opt.formatoptions:remove('c')
		vim.opt.formatoptions:remove('r')
		vim.opt.formatoptions:remove('o')
	end,
	desc = 'Disable auto-commenting the next line'
})
-- TODO: test that disable continued comments works
-- To switch buffers
vim.opt.hidden = true

-- Editing: remaps
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', { noremap = true })
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>p', '"_dP', { noremap = true })
-- Leaving the terminal easily
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })
-- Strikethrough in markdown lists
vim.api.nvim_set_keymap('n', '<Leader>s', '_wi~~<Esc>A~~<Esc>0', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>S', '_f~xxf~xx0', { noremap = true })
-- Selection utilities for misc. personal use
vim.api.nvim_set_keymap('n', '<Leader>v', '^vg_', { noremap = true });
vim.api.nvim_set_keymap('n', '<Leader>ma', '?* <CR>:noh<CR>wvg_', { noremap = true });
-- Window navigation
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true })
-- TODO: smart tab for autocompletion (instead of <C-n>) ?
-- Ctrl+L should also refresh screen
vim.api.nvim_set_keymap('n', '<C-l>', ':redraw!<cr>:noh<cr><C-w>l', { noremap = true })

-- Editing: custom commands
vim.api.nvim_create_user_command('Use8Tab',
	function()
		vim.opt.ts = 8
		vim.opt.sw = 8
		vim.opt.expandtab = false
	end, {}
)
vim.api.nvim_create_user_command('Use8Space',
	function()
		vim.opt.ts = 8
		vim.opt.sw = 8
		vim.opt.expandtab = true
	end, {}
)
vim.api.nvim_create_user_command('Use4Tab',
	function()
		vim.opt.ts = 4
		vim.opt.sw = 4
		vim.opt.expandtab = false
	end, {}
)
vim.api.nvim_create_user_command('Use4Space',
	function()
		vim.opt.ts = 4
		vim.opt.sw = 4
		vim.opt.expandtab = true
	end, {}
)
vim.api.nvim_create_user_command('WritingMode',
	function()
		vim.opt.background = 'light'
		vim.opt.breakindent = true
		vim.opt.linebreak = true
	end, {}
)
vim.api.nvim_create_user_command('ListMode',
	function()
		vim.opt.breakindent = true
		vim.opt.linebreak = true
		vim.opt.ts = 4
		vim.opt.sw = 4
		vim.opt.expandtab = false
		vim.opt.display:append { 'lastline' }
		vim.opt.autoindent = true
	end, {}
)
vim.api.nvim_create_user_command('HideBackground',
	function()
		vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
	end, {}
)

-- Plugins: install using `junegunn/vim-plug` (`:PlugInstall`)
-- DO: Put plug.vim into autoload directory
-- RUN: `:PlugInstall`
local Plug = vim.fn['plug#']
vim.call('plug#begin')
-- Fzf
Plug('junegunn/fzf', { ['do'] = function()
	vim.fn['fzf#install']()
end })
Plug('junegunn/fzf.vim')
-- Misc.
Plug('preservim/nerdtree')
Plug('airblade/vim-gitgutter')
Plug('nvim-lualine/lualine.nvim')
Plug('folke/zen-mode.nvim')
-- Themes: main
Plug('cocopon/iceberg.vim')
Plug('ellisonleao/gruvbox.nvim')
Plug('rebelot/kanagawa.nvim')
Plug('folke/tokyonight.nvim')
Plug('sainnhe/everforest')
-- Themes: misc.
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug('embark-theme/vim', { as = 'embark' })
Plug('nordtheme/vim')
-- Themes: joke/showcase
Plug('Mofiqul/vscode.nvim') -- Lua port of tomasiser/vim-code-dark
Plug('dundargoc/fakedonalds.nvim')
-- TODO: find more color schemes?
-- Tree
Plug('nvim-tree/nvim-tree.lua')
Plug('ryanoasis/vim-devicons')
-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = vim.fn['TSUpdate'] })
-- LSP
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('nvim-lua/plenary.nvim')
Plug('pmizio/typescript-tools.nvim')
Plug('VonHeikemen/lsp-zero.nvim', { branch = 'v3.x' })
vim.call('plug#end')

-- Plugins: preferences/config
-- Misc.
vim.g.NERDTreeChDirMode = 2
require('lualine').setup({
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {'tabs'}
	}
})
-- TreeSitter
-- Parsers (see <https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages>)
-- DO: prerequisites in Windows: C compiler (ex. gcc) added to PATH
-- RUN: `:TSInstall javascript html cpp vimdoc comment markdown markdown_inline`
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true
	}
})
-- LSPs (see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md>)
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- :help `lsp-zero-keybindings` shows available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').lua_ls.setup({})
require('lspconfig').html.setup({})
-- require('lspconfig').js.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').pylsp.setup({})
require('typescript-tools').setup({})
-- TODO: LSPs for C++, JS/TS

-- Appearance: colors
vim.opt.termguicolors = true
vim.opt.background = 'dark'
-- Use iceberg, with sorbet as a built-in backup
vim.cmd('colorscheme sorbet')
vim.cmd('colorscheme iceberg')

-- Neovide GUI configuration
if vim.g.neovide then
	-- Fallback (Consolas) and ideal (`Znuff/consolas-powerline`) fonts
	vim.opt.guifont = 'Consolas:h11:cANSI'
	vim.opt.guifont = 'Consolas 7NF:h11'
	vim.g.neovide_position_animation_length = 0.1
	vim.g.neovide_scroll_animation_length = 0.2
	-- Floating blur
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	-- For Airline
	vim.g.airline_powerline_fonts = 1
	-- Fullscreen with F11
	vim.api.nvim_set_keymap('n', '<F11>', ':let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', {})
end
