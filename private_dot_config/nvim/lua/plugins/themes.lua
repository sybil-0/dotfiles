return {
  {
    'EdenEast/nightfox.nvim',
    config = function() end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
  },
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    --= ---@type solarized.config
    -- opts = {},
    -- config = function(_, opts)
    --     vim.o.termguicolors = true
    --     vim.o.background = 'dark'
    --     require('solarized').setup(opts)
    --     vim.cmd.colorscheme 'solarized'
    -- end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.o.termguicolors = true
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
