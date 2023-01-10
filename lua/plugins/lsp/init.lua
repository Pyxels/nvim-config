local handler = require('plugins.lsp.handlers')

return {

  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      handler.setup()
    end
  },

  { 'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig', -- enable LSP
      'simrat39/rust-tools.nvim',
    },
    config = function()
      local lspconfig = require('lspconfig')
      require('mason-lspconfig').setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          local opts = {
            on_attach = handler.on_attach,
            capabilities = handler.capabilities,
          }
          local has_custom_opts, server_custom_opts = pcall(require, 'user.lsp.settings.' .. server_name)
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
            settings = {
              ['rust-analyzer'] = {
                assist = {
                  importGranularity = 'module',
                  importPrefix = 'by_self',
                },
                cargo = {
                  loadOutDirsFromCheck = true,
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          })
          vim.keymap.set(
            'n',
            '<leader>lR',
            "<cmd>lua require('rust-tools.runnables').runnables()<CR>",
            { desc = 'LSP: rust runnables' }
          )
        end,
      })
    end
  },

  'neovim/nvim-lspconfig', -- enable LSP

  'simrat39/rust-tools.nvim',

  {
    'jose-elias-alvarez/null-ls.nvim',
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
    end
  }, -- for formatters and linters


  { -- Crates for Rust
    'saecki/crates.nvim',
    lazy = true,
    event = 'BufRead Cargo.toml',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },
  {
    'elkowar/yuck.vim', -- filetype support for eww configuration language
    lazy = true,
    event = 'BufRead *.yuck',
  },
  {
    'ron-rs/ron.vim', -- filetype support for rust object notation (rom) language
    lazy = true,
    event = 'BufRead *.ron',
  },

}

