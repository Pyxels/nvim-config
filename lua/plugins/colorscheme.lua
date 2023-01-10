return {
  {
    'luisiacc/gruvbox-baby',
    lazy = false,
    priority = 1000,
    config = function()
      -- Enable telescope theme
      vim.g.gruvbox_baby_telescope_theme = 0

      -- Enable transparent mode
      vim.g.gruvbox_baby_transparent_mode = 0

      -- Load the colorscheme
      vim.cmd([[
try
  colorscheme gruvbox-baby
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]     )
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    keys = { { '<Leader>t', '<cmd>ColorizerToggle <cr>', desc = '[T]oggle colorizer' } },
  },
}
