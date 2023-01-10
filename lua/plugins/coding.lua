return {
  { -- surround text objects with ( { " ....
    'kylechui/nvim-surround',
    lazy = true,
    opts = {},
    keys = {
      { 'ys' },
      { 'ds' },
      { 'cs' },
    },
  },

  { -- Easily comment stuff
    'numToStr/Comment.nvim',
    lazy = true,
    opts = {},
    keys = {
      { 'gcc' },
      { 'gbc' },
      { 'gc', mode = 'v' },
      { 'gb', mode = 'v' },
    },
  },
}
