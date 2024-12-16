-- Bootstrap lazy.nvim
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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
			end,
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			"EdenEast/nightfox.nvim",
			config = function()
				vim.o.termguicolors = true
				vim.o.background = "dark"
				vim.cmd.colorscheme("carbonfox")
			end,
		},
		{
			"nyoom-engineering/oxocarbon.nvim",
			-- Add in any other configuration;
			--   event = foo,
			--   config = bar
			--   end,
		},
		{
			"maxmx03/solarized.nvim",
			lazy = false,
			priority = 1000,
			---@type solarized.config
			opts = {},
			config = function(_, opts)
				vim.o.termguicolors = true
				vim.o.background = "dark"
				require("solarized").setup(opts)
				vim.cmd.colorscheme("solarized")
			end,
		},
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind using [G]rep" })
				vim.keymap.set("n", "<leader><SPACE>", builtin.buffers, { desc = "browse buffers" })
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "show help tags" })
			end,
		},
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			-- Optional dependencies
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
			config = function()
				require("oil").setup()
				vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				icons = {
					-- set icon mappings to true if you have a Nerd Font
					mappings = vim.g.have_nerd_font,
					-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
					-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
					keys = vim.g.have_nerd_font and {} or {
						Up = "<Up> ",
						Down = "<Down> ",
						Left = "<Left> ",
						Right = "<Right> ",
						C = "<C-…> ",
						M = "<M-…> ",
						D = "<D-…> ",
						S = "<S-…> ",
						CR = "<CR> ",
						Esc = "<Esc> ",
						ScrollWheelDown = "<ScrollWheelDown> ",
						ScrollWheelUp = "<ScrollWheelUp> ",
						NL = "<NL> ",
						BS = "<BS> ",
						Space = "<Space> ",
						Tab = "<Tab> ",
						F1 = "<F1>",
						F2 = "<F2>",
						F3 = "<F3>",
						F4 = "<F4>",
						F5 = "<F5>",
						F6 = "<F6>",
						F7 = "<F7>",
						F8 = "<F8>",
						F9 = "<F9>",
						F10 = "<F10>",
						F11 = "<F11>",
						F12 = "<F12>",
					},
				},

				-- Document existing key chains
				spec = {
					{ "<leader>f", group = "[F]ile operations", mode = { "n", "x" } },
					{ "<leader>b", group = "[B]uffer operations" },
					{ "<leader>e", group = "Explorer" },
					{ "<leader>a", group = "Code [A]ctions" },
				},
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"stevearc/conform.nvim",
			opts = {},
		},
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
		},
		{ "Olical/conjure" },
		{ "oHeikemen/lsp-zero.nvim", branch = "v4.x" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "L3MON4D3/LuaSnip" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	install = { colorscheme = { "nightfox" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Keymaps

-- Make line numbers default
vim.opt.number = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-- Don't show the mode, since it's already in status line
vim.opt.showmode = false
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"
-- Enable break indent
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- Show which line your cursor is on
vim.opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- 24 bit colors
vim.opt.termguicolors = true

-- General Keymaps
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", [[<C-\><C-n>]]) -- normal mode mapping for term emulator
vim.keymap.set("n", "<leader>ex", ":Ex %:p:h<CR>", { desc = "open file explorer" })

-- LSP config
local lsp_zero = require("lsp-zero")

local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }

	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
	vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

lsp_zero.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	float_border = "rounded",
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

local cmp = require("cmp")
local cmp_action = lsp_zero.cmp_action()

-- this is the function that loads the extra snippets
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 3 },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- confirm completion item
		["<Enter>"] = cmp.mapping.confirm({ select = true }),
		-- trigger completion menu
		["<C-Space>"] = cmp.mapping.complete(),
		-- scroll up and down the documentation window
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		-- navigate between snippet placeholders
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
	}),
	-- note: if you are going to use lsp-kind (another plugin)
	-- replace the line below with the function from lsp-kind
	formatting = lsp_zero.cmp_format({ details = true }),
})

-- Telescope config
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
				["<c-d>"] = require("telescope.actions").delete_buffer,
			},
		},
	},
})

-- Automatic Formatting

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- other custom keybindings
vim.keymap.set("n", "<leader>bh", "<CMD>browse oldfiles<CR>", { desc = "browse history" })
vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>", {})
