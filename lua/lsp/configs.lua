local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local status_ok, mason_lsp = pcall(require, 'mason-lspconfig')
if not status_ok then
  return
end

mason.setup()
mason_lsp.setup()

local lspconfig = require('lspconfig')
local handler = require('lsp.handlers')

mason_lsp.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local opts = {
      on_attach = handler.on_attach,
      capabilities = handler.capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, 'lsp.settings.' .. server_name)
    if has_custom_opts then
      opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
    end
    lspconfig[server_name].setup(opts)
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ['rust_analyzer'] = function()
    require('rust-tools').setup({
      server = { on_attach = handler.on_attach },
      require('lsp.settings.rust_analyzer'),
    })
    vim.keymap.set(
      'n',
      '<leader>lR',
      "<cmd>lua require('rust-tools.runnables').runnables()<CR>",
      { desc = 'LSP: rust runnables' }
    )
  end,
  ['volar'] = function()
    local custom_on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      handler.on_attach(client, bufnr)
    end
    lspconfig['volar'].setup({ on_attach = custom_on_attach, capabilities = handler.capabilities })
  end,
  ['tsserver'] = function()
    local custom_on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      handler.on_attach(client, bufnr)
    end
    lspconfig['tsserver'].setup({ on_attach = custom_on_attach, capabilities = handler.capabilities })
  end,
})
