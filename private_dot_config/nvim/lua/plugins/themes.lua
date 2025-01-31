return {
	{
		'EdenEast/nightfox.nvim',
		config = function() end,
	},
	{
		'nyoom-engineering/oxocarbon.nvim',
		config = function()
			vim.o.termguicolors = true
			vim.o.background = 'dark'
			vim.cmd.colorscheme 'oxocarbon'
		end,
	},
	{
		'maxmx03/solarized.nvim',
		lazy = false,
		priority = 1000,
	},
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
