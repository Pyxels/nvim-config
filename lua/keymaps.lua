local keymap = vim.keymap.set

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
keymap('n', '<C-h>', '<C-w>h', { desc = 'Select the window to the left' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Select the window to the bottom' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Select the window to the top' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Select the window to the right' })

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', { desc = 'Resize +2' })
keymap('n', '<C-Down>', ':resize -2<CR>', { desc = 'Resize -2' })
keymap('n', '<C-Left>', ':vertical resize +2<CR>', { desc = 'Resize +2' })
keymap('n', '<C-Right>', ':vertical resize -2<CR>', { desc = 'Resize -2' })

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', { desc = 'Next buffer' })
keymap('n', '<S-h>', ':bprevious<CR>', { desc = 'Previous buffer' })

keymap('n', '<C-d>', '<C-d>zz', { desc = 'Half page navigation and centering' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Half page navigation and centering' })

keymap('n', 'n', 'nzz', { desc = 'Center when moving through search' })
keymap('n', '<S-n>', '<S-n>zz', { desc = 'Center when moving through search' })

---------------------------
---- Text Manipulation ----
---------------------------
-- Normal --
-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==', { desc = 'Move line down' })
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==', { desc = 'Move line up' })

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', { desc = 'Unindent block and stay in Visual' })
keymap('v', '>', '>gv', { desc = 'Indent block and stay in Visual' })

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', { desc = 'Move text block up' })
keymap('v', '<A-k>', ':m .-2<CR>==', { desc = 'Move text block down' })

-- When pasting on selection keep pasted in register
keymap('v', 'p', '"_dP', { desc = 'When pasting on selection keep pasted in register' })

-- Visual Block --
-- Move text up and down
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", { desc = 'Move visual block down' })
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", { desc = 'Move visual block up' })

-- Clipboard only with leader --
keymap({ 'n', 'v' }, '<Leader>y', '"+y')
keymap('n', '<Leader>Y', '"+Y')
keymap({ 'n', 'v' }, '<Leader>p', '"+p')

---------------------------
------- Small Fixes -------
---------------------------
-- Make qw act like wq
keymap('c', 'qw', 'wq', { desc = 'When mistyping qw, use wq' })

-- Disable p (paste) in Select mode
keymap('s', 'p', 'p', { desc = 'Disable paste in Select mode' })

---------------------------
---------- Basic ----------
---------------------------

keymap('n', '<Leader>r', '<cmd>w!<CR>', { desc = 'Save' })
keymap('n', '<Leader>c', '<cmd>Bdelete!<CR>', { desc = 'Close current Buffer' })
keymap('n', '<Leader>h', '<cmd>nohlsearch<CR>', { desc = 'Remove highlights' })

keymap(
  { 'n', 'i', 'v' },
  '<C-t>',
  ":execute '!alacritty --working-directory `git rev-parse --show-toplevel || pwd` &'<CR>",
  { desc = 'Open [T]erminal', silent = true }
)

---------------------------
----------- LSP -----------
---------------------------
-- These are needed outside the on-attach lsp function so they can be called even if no lsp server is attached
