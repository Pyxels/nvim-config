return {

  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    keys = { { '<Leader>lI', '<cmd>Mason<cr>', desc = 'Mason [I]nfo' } },
  },

  'williamboman/mason-lspconfig.nvim',

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    dependencies = {
      'j-hui/fidget.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    keys = { { '<Leader>li', '<cmd>LspInfo<cr>', desc = 'LSP: Current Info' } },
    config = function()
      require('lsp')
    end,
  }, -- enable LSP

  'simrat39/rust-tools.nvim',

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPost',
    config = function()
      local null_ls = require('null-ls')
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
    end,
  }, -- for formatters and linters

  { -- Crates for Rust
    'saecki/crates.nvim',
    lazy = true,
    event = 'BufReadPre Cargo.toml',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    opts = {},
  },
  {
    'elkowar/yuck.vim', -- filetype support for eww configuration language
    lazy = true,
    event = 'BufReadPre *.yuck',
  },
  {
    'ron-rs/ron.vim', -- filetype support for rust object notation (rom) language
    lazy = true,
    event = 'BufReadPre *.ron',
  },
}
