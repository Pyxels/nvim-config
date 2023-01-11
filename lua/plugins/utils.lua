return {
  { -- Vim Wiki
    'vimwiki/vimwiki',
    lazy = true,
    keys = {
      { '<Leader>ww' },
      { '<Leader>ws' },
    },
    cmd = 'VimwikiIndex',
  },

  { -- Code time usage
    'wakatime/vim-wakatime',
    event = 'VeryLazy',
  },

  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  }, -- Useful lua functions used in lots of plugins

  {
    'moll/vim-bbye',
    event = 'BufEnter',
  }, -- close buffers without messing up layout
}
