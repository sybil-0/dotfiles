return {

    {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
	    local builtin = require 'telescope.builtin'
	    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
	    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind using [G]rep' })
	    vim.keymap.set('n', '<leader><SPACE>', builtin.buffers, { desc = 'browse buffers' })
	    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'show help tags' })
	end,
    },
    {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { 'echasnovski/mini.icons', opts = {} } },
	config = function()
	    require('oil').setup()
	    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
	end,
    },
}
