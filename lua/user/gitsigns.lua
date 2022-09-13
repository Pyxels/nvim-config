local status_ok, gitsigns = pcall(require, 'gitsigns')
if not status_ok then
  return
end

local keymap = vim.keymap.set

keymap('n', '<Leader>gj', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { desc = 'Git: Next Hunk' })
keymap('n', '<Leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { desc = 'Git: Prev Hunk' })
keymap('n', '<Leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { desc = 'Git: Preview Hunk' })
keymap('n', '<Leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { desc = 'Git: Reset Hunk' })
keymap('n', '<Leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { desc = 'Git: Reset Buffer' })
keymap('n', '<Leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", { desc = 'Git: Stage Hunk' })
keymap('n', '<Leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", { desc = 'Git: Undo Stage Hunk' })

gitsigns.setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})
