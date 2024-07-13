-- init.lua for Cadecraft
-- R: v0.3.0, E: 2024/07/13

-- This file also contains the translated contents of my vimrc from regular Vim, so it can be used by itself without a vimrc dependency

-- By default, filetype, plugin, indent, and syntax on are enabled

-- Location for swap files (the tmp folder must be created)
local prefix = vim.fn.expand('~/.nvim')
vim.opt.backupdir = { prefix .. '/.tmp//' }
vim.opt.directory = { prefix .. '/.tmp//' }

-- Appearance: preferences
vim.opt.number = true
vim.opt.cursorline = true

-- Editing: preferences
vim.opt.clipboard = 'unnamed'
vim.opt.so = 8
vim.opt.backspace = { 'indent', 'eol' }
-- Disable auto-commenting the next line
--[[autocmd('FileType', {
	pattern = { 'rust', 'c', 'cpp', 'py', 'java', 'cs' },
	callback = function()
		vim.opt.formatoptions:remove('c')
		vim.opt.formatoptions:remove('r')
		vim.opt.formatoptions:remove('o')
	end,
	group = general,
	desc = 'Disable auto-commenting next line in these filetypes',
})--]]
-- TODO: test that disable continued comments works still, even without autocmd above
vim.opt.formatoptions:remove('c')
vim.opt.formatoptions:remove('r')
vim.opt.formatoptions:remove('o')
-- TODO: FIX disabling continued comments
-- To switch buffers
vim.opt.hidden = true

-- Editing: remaps/commands
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true })

-- TODO: tnoremap <C-W>n <C-\><C-n> for terminal

-- Editing: custom commands
vim.api.nvim_create_user_command('Use4Space',
	function()
		vim.opt.ts = 4
		vim.opt.sw = 4
		vim.opt.expandtab = true
	end, {}
)
vim.api.nvim_create_user_command('Use8Tab',
	function()
		vim.opt.ts = 8
		vim.opt.sw = 8
		vim.opt.expandtab = false
		-- TODO: test these commands
	end, {}
)

-- Plugins: install using vim-plug (`:PlugInstall`)
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
Plug('vim-airline/vim-airline')
-- Themes
Plug('cocopon/iceberg.vim')
Plug('embark-theme/vim')
-- Tree
Plug('nvim-tree/nvim-tree.lua')
Plug('ryanoasis/vim-devicons')
-- LSP
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('L3MON4D3/LuaSnip')
Plug('VonHeikemen/lsp-zero.nvim', { branch = 'v3.x' })
vim.call('plug#end')

-- Plugins: preferences/config
-- Misc.
vim.g.NERDTreeChDirMode = 2
-- LSPs (see <https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md>)
local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(client, bufnr)
	-- :help `lsp-zero-keybindings` shows available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)
require('lspconfig').sourcekit.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').lua_ls.setup({})
-- TODO: LSPs for C++, Python, JS, HTML, CSS

-- Appearance: colors
vim.opt.termguicolors = true
vim.opt.background = 'dark'
-- The iceberg colorscheme (`cocopon/iceberg.vim`)
vim.cmd('colorscheme iceberg')

-- Neovide GUI configuration
if vim.g.neovide then
	-- Fallback (Consolas) and ideal (`Znuff/consolas-powerline`) fonts
	vim.opt.guifont = 'Consolas:h11:cANSI'
	vim.opt.guifont = 'Consolas 7NF:h11'
	vim.g.neovide_position_animation_length = 0.1
	vim.g.neovide_scroll_animation_length = 0.2
	-- For Airline
	vim.g.airline_powerline_fonts = 1
	-- Fullscreen with F11
	vim.api.nvim_set_keymap('n', '<F11>', ':let g:neovide_fullscreen = !g:neovide_fullscreen<CR>', {})
end
