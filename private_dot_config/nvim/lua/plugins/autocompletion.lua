return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').pyright.setup {}
      require('lspconfig').lua_ls.setup {}
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client:supports_method 'textDocument/completion' then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
          end
        end,
      })
    end,
  },
}
