return {
  { -- surround text objects with ( { " ....
    'kylechui/nvim-surround',
    opts = {},
    keys = {
      { 'ys' },
      { 'ds' },
      { 'cs' },
      { 'S', mode = 'v' },
    },
  },

  { -- Easily comment stuff
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { 'gcc' },
      { 'gbc' },
      { 'gc', mode = 'v' },
      { 'gb', mode = 'v' },
    },
  },
}
