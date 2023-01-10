local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    -- JS, JSON, TS
    formatting.prettier.with({ extra_args = { '--single-quote', '--jsx-single-quote' } }),

    -- Python
    formatting.black.with({ extra_args = { '--fast' } }),
    -- diagnostics.flake8

    -- Lua
    formatting.stylua,

    -- LaTeX
    -- diagnostics.chktex,
    formatting.latexindent,
    formatting.bibclean,

    -- Bash / sh
    formatting.beautysh,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = require('lsp.handlers').on_attach,
})
