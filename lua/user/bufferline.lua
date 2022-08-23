local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  return
end

bufferline.setup({
  options = {
    close_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'Bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = true,
    offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = false,
  },
})
