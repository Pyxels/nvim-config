local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = 'DiagnosticSignError', text = '' },
    { name = 'DiagnosticSignWarn', text = '' },
    { name = 'DiagnosticSignHint', text = '' },
    { name = 'DiagnosticSignInfo', text = '' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end

  local config = {
    -- disable virtual text
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
  })

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  local status_ok, illuminate = pcall(require, 'illuminate')
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

local function lsp_keymaps()
  local keymap = vim.keymap.set
  keymap('n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', {desc = 'LSP: Code Action' })
  keymap('n', '<Leader>ld', '<cmd>Telescope diagnostics<cr>', {desc = 'LSP: Document Diagnostics', })
  keymap('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', {desc = 'LSP: Format' })
  keymap('n', '<Leader>lj', '<cmd>lua vim.diagnostic.goto_next()<CR>', {desc = 'LSP: Next Diagnostic', })
  keymap('n', '<Leader>lk', '<cmd>lua vim.diagnostic.goto_prev()<cr>', {desc = 'LSP: Prev Diagnostic', })
  keymap('n', '<Leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', {desc = 'LSP: CodeLens Action' })
  keymap('n', '<Leader>lq', "<cmd>lua vim.diagnostic.setloclist()<cr>", {desc = "Add diagnostics to quickfix list" })
  keymap('n', '<Leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>', {desc = 'LSP: Rename' })
  keymap('n', '<Leader>ls', '<cmd>Telescope lsp_document_symbols<cr>', {desc = 'LSP: Document Symbols' })

  keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', {desc = 'LSP: Show definition'})
  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {desc = 'LSP: Hover'})
  keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {desc = 'LSP: Show implemetation'})
  keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {desc = 'LSP: Signature help'})
  keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', {desc = 'LSP: Show references'})
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
end

M.on_attach = function(client, bufnr)
  if client.name == 'sumneko_lua' then
    client.server_capabilities.document_formatting = false
  end
  if client.name == 'rust_analyzer' then
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      '<leader>lR',
      "<cmd>lua require('rust-tools.runnables').runnables()<CR>",
      { noremap = true, silent = true }
    )
  end
  if client.name == 'tsserver' then
    client.server_capabilities.document_formatting = false
  end

  lsp_keymaps()
  lsp_highlight_document(client)
  vim.notify(string.format("Lsp-Server '%s' attached to buffer.", client.name))
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
