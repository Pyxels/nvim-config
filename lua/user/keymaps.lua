local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local function keymap(mode, mapping, to)
  vim.api.nvim_set_keymap(mode, mapping, to, opts)
end

--Remap space as leader key
keymap('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

---------------------------
------- Navigation --------
---------------------------
-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>')
keymap('n', '<C-Down>', ':resize -2<CR>')
keymap('n', '<C-Left>', ':vertical resize +2<CR>')
keymap('n', '<C-Right>', ':vertical resize -2<CR>')

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>')
keymap('n', '<S-h>', ':bprevious<CR>')



---------------------------
---- Text Manipulation ----
---------------------------
-- Normal --
-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==')
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==')

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==')
keymap('v', '<A-k>', ':m .-2<CR>==')
keymap('v', 'p', '"_dP')

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv")
keymap('x', 'K', ":move '<-2<CR>gv-gv")
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv")
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv")


---------------------------
------- Small Fixes -------
---------------------------
-- Make qw act like wq
keymap('c', 'qw', 'wq')

-- Disable p (paste) in Select mode
keymap('s', 'p', 'p')


---------------------------
--------- Plugins ---------
---------------------------

