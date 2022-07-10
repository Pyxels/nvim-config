-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = 0

-- Enable transparent mode
vim.g.gruvbox_baby_transparent_mode = 0

-- Set background color in visual mode
local colors = require("gruvbox-baby.colors").config()
vim.g.gruvbox_baby_highlights = { Visual = { bg = colors.medium_gray } }

-- Load the colorscheme
vim.cmd([[
try
  colorscheme gruvbox-baby
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

require("colorizer").setup()
