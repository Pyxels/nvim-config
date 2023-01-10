return {
  { -- Vim Wiki
    'vimwiki/vimwiki',
    lazy = true,
  },

  { -- Code time usage
    'wakatime/vim-wakatime',
    lazy = false,
  },

  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  }, -- Useful lua functions used in lots of plugins

  {
    'moll/vim-bbye',
    lazy = false,
  }, -- close buffers without messing up layout
}
