-- init.lua for Cadecraft
-- R: v0.8.8, E: 2025/04/30

-- This file also contains the translated contents of my vimrc from regular Vim, so it can be used by itself without a vimrc dependency

-- By default, filetype, plugin, indent, and syntax on are enabled

-- Location for swap files (the tmp folder must be created)
local prefix = vim.fn.expand('~/.nvim')
vim.opt.backupdir = { prefix .. '/.tmp//' }
vim.opt.directory = { prefix .. '/.tmp//' }

-- Use PowerShell in Windows
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
	vim.o.shell = "powershell.exe"
	vim.o.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
	vim.o.shellxquote = ''
end

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim (source: <https://lazy.folke.io/installation>)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

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
-- To switch buffers
vim.opt.hidden = true

-- Editing: remaps
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', { noremap = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('v', '<Leader>p', '"_dP', { noremap = true })
-- Diagnostics
vim.api.nvim_set_keymap('n', '<Leader>K', ':lua vim.diagnostic.open_float()<CR>', { noremap = true })
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
-- Ctrl+L should also refresh screen
vim.api.nvim_set_keymap('n', '<C-l>', ':redraw!<cr>:noh<cr><C-w>l', { noremap = true })
-- Efficiently create a new terminal in a new tab and start appending to the input
vim.api.nvim_set_keymap('n', '<Leader>tt', ':tabnew | term<cr>a<C-l>', { noremap = true })

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
vim.api.nvim_create_user_command('Use2Tab',
	function()
		vim.opt.ts = 2
		vim.opt.sw = 2
		vim.opt.expandtab = false
	end, {}
)
vim.api.nvim_create_user_command('Use2Space',
	function()
		vim.opt.ts = 2
		vim.opt.sw = 2
		vim.opt.expandtab = true
	end, {}
)
vim.api.nvim_create_user_command('Cdcurr',
	function()
		vim.cmd([[
			cd %:p:h
		]])
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
		vim.opt.ignorecase = true
		vim.opt.so = 8
	end, {}
)
vim.api.nvim_create_user_command('HideBackground',
	function()
		vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
	end, {}
)

require("lazy").setup({
	spec = {
		-- Fuzzy finding
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.8',
			dependencies = { 'nvim-lua/plenary.nvim' }
		},
		-- Misc. editor
		{
			"nvim-tree/nvim-tree.lua",
			dependencies = {
				"nvim-tree/nvim-web-devicons"
			},
			config = function()
				require("nvim-tree").setup {
					filters = {
						dotfiles = false
					}
				}
			end
		},
		{ "lewis6991/gitsigns.nvim" },
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' }
		},
		{ 'folke/zen-mode.nvim' },
		{ 'tpope/vim-surround' },
		-- Misc. integrations
		{ 'lervag/vimtex' },
		-- Themes: main
		{ 'oahlen/iceberg.nvim' }, -- Default
		{ 'ellisonleao/gruvbox.nvim' }, -- Games
		{ 'rebelot/kanagawa.nvim' }, -- Rust
		{ 'folke/tokyonight.nvim' }, -- Misc.
		{ 'sainnhe/everforest' }, -- Web dev
		-- Themes: misc.
		{ 'catppuccin/nvim', name = 'catppuccin' },
		{ 'embark-theme/vim', name = 'embark' },
		{ 'nordtheme/vim' },
		{ 'lewpoly/sherbet.nvim' }, -- C programming (old)
		{ 'vague2k/vague.nvim' }, -- C programming
		{ 'AlexvZyl/nordic.nvim' }, -- When bored (also C programming)
		{ 'savq/melange-nvim' }, -- Warmer
		-- Themes: joke/showcase
		{ 'Mofiqul/vscode.nvim' }, -- Lua port of tomasiser/vim-code-dark
		{ 'dundargoc/fakedonalds.nvim' },
		{ 'jamescherti/vim-tomorrow-night-deepblue' },
		{ 'xiantang/darcula-dark.nvim' }, -- Nvim port of the JetBrains colorscheme
		-- TODO: find more color schemes?
		-- Tree
		{ 'nvim-tree/nvim-tree.lua' },
		{ 'ryanoasis/vim-devicons' },
		-- Treesitter
		{
			'nvim-treesitter/nvim-treesitter',
			build = ":TSUpdate",
			config = function ()
				local configs = require("nvim-treesitter.configs")
				-- Parsers (see <https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages>)
				-- DO: prerequisites in Windows: C compiler (ex. gcc) added to PATH
				configs.setup({
					ensure_installed = {
						"javascript",
						"html",
						"css",
						"cpp",
						"vimdoc",
						"comment",
						"markdown",
						"markdown_inline",
						"python",
						"rust",
						"java",
						"c"
					},
					highlight = {
						enable = true
					},
					indent = {
						-- Disable the inbuilt indent for all treesitter languages except js/ts
						-- This partly solves the indent issue for jsx files
						enable = true,
						disable = {
							"html",
							"css",
							"cpp",
							"vimdoc",
							"comment",
							"markdown",
							"markdown_inline",
							"python",
							"rust",
							"java",
							"c"
						}
					}
				})
			end
		},
		-- LSP and languages
		{ 'neovim/nvim-lspconfig' },
		{ 'hrsh7th/nvim-cmp' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'L3MON4D3/LuaSnip' },
		{ 'nvim-lua/plenary.nvim' },
		{ 'pmizio/typescript-tools.nvim' },
		{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
		{ 'MaxMEllon/vim-jsx-pretty' },
	},
	checker = { enabled = true, notify = false },
})

-- Plugins: preferences/config
-- Misc.
--vim.g.NERDTreeChDirMode = 2
if vim.fn.exists('g:loaded_webdevicons') then
	vim.cmd('call webdevicons#refresh()')
end
require('lualine').setup({
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {'tabs'}
	}
})
require('gitsigns').setup()
-- Telescope setup and shortcuts
-- DO: install ripgrep (for live grep)
require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			".git",
			"node_modules"
		}
	}
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })

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
require('lspconfig').clangd.setup({})
-- Note: for eslint to display errors in diagnostics, may need to downgrade? (npm i -g vscode-langservers-extracted@4.8.0)
require('lspconfig').eslint.setup({
	flags = {
		allow_incremental_sync = false,
		debounce_text_changes = 1000,
	}
})
require('typescript-tools').setup({})

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
	-- Disable animations with a command
	vim.api.nvim_create_user_command('DisableAnimationsNeovide',
		function()
			vim.g.neovide_position_animation_length = 0
			vim.g.neovide_cursor_animation_length = 0.00
			vim.g.neovide_cursor_trail_size = 0
			vim.g.neovide_cursor_animate_in_insert_mode = false
			vim.g.neovide_cursor_animate_command_line = false
			vim.g.neovide_scroll_animation_far_lines = 0
			vim.g.neovide_scroll_animation_length = 0.00
		end, {}
	)
	-- Fake PyCharm
	vim.api.nvim_create_user_command('FakePycharm',
	function()
		vim.cmd('colorscheme darcula-dark')
		vim.opt.guifont = 'Jetbrains Mono:h11'
		vim.opt.title = true
		vim.opt.titlestring = 'PyCharm'
	end, {}
)
end
