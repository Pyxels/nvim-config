return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    opts = {
      ensure_installed = 'all',
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { '' }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { '' }, -- list of language that will be disabled
      },
      indent = { enable = true, disable = { 'yaml' } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
    config = function(plugin, opts)
      if plugin.ensure_installed then
        require("lazyvim.util").deprecate("treesitter.ensure_installed", "treesitter.opts.ensure_installed")
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
