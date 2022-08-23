local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

function SetRelativeAndHighlight(setTo)
  local bufnr = vim.api.nvim_get_current_buf()
  local exclude = {
    [''] = true,
    ['NvimTree'] = true,
    ['qf'] = true,
    ['alpha'] = true,
  }

  if exclude[vim.api.nvim_buf_get_option(bufnr, 'filetype')] then
    return
  end
  vim.o.relativenumber = setTo
  vim.o.cul = setTo
end

-- General Settings
local generalGrp = augroup('GeneralSettings', { clear = true })
-- Highlight on yank
autocmd('TextYankPost', {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})",
  group = generalGrp,
})
-- Quick close for help, man ...
autocmd('FileType', {
  pattern = { 'qf', 'help', 'man', 'lspinfo' },
  command = 'nnoremap <silent> <buffer> q :close <CR>',
  group = generalGrp,
})
-- Hide buffers from bufferlist
autocmd('FileType', {
  pattern = { 'qf' },
  command = 'FileType qf set nobuflisted',
  group = generalGrp,
})
-- Set relativenumber and line
autocmd('WinEnter', {
  callback = function() SetRelativeAndHighlight(true) end,
  group = generalGrp,
})
autocmd('WinLeave', {
  callback = function() SetRelativeAndHighlight(false) end,
  group = generalGrp,
})

-- Git
local gitGrp = augroup('GitSettings', { clear = true })
autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'setlocal wrap',
  group = gitGrp,
})
autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'setlocal spell',
  group = gitGrp,
})

-- Automatically compile latex script upon saving
local texGrp = augroup('TexSettings', { clear = true })
autocmd('BufWritePost', {
  pattern = { '*.tex' },
  command = 'silent! execute "!pdflatex -shell-escape -output-directory=%:p:h %:p > /dev/null 2>&1" | redraw!',
  group = texGrp,
})

-- Alpha
local alphaGrp = augroup('AlphaSettings', { clear = true })
autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2',
  group = alphaGrp,
})
autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set cul',
  group = alphaGrp,
})
autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set norelativenumber',
  group = alphaGrp,
})

