local api = vim.api

function SetRelativeAndHighlight(setTo)
  local bufnr = api.nvim_get_current_buf()
  local exclude = {
    [''] = true,
    ['NvimTree'] = true,
    ['qf'] = true,
    ['alpha'] = true,
  }

  if exclude[api.nvim_buf_get_option(bufnr, 'filetype')] then
    return
  end
  vim.o.relativenumber = setTo
  vim.o.cul = setTo
end

-- General Settings
local generalGrp = api.nvim_create_augroup('GeneralSettings', { clear = true })
-- Highlight on yank
api.nvim_create_autocmd('TextYankPost', {
  command = "silent! lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})",
  group = generalGrp,
})
-- Quick close for help, man ...
api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'help', 'man', 'lspinfo' },
  command = 'nnoremap <silent> <buffer> q :close <CR>',
  group = generalGrp,
})
-- Hide buffers from bufferlist
api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  command = 'FileType qf set nobuflisted',
  group = generalGrp,
})
-- Set relativenumber and line
api.nvim_create_autocmd('WinEnter', {
  command = 'lua SetRelativeAndHighlight( true )',
  group = generalGrp,
})
api.nvim_create_autocmd('WinLeave', {
  command = 'lua SetRelativeAndHighlight( false )',
  group = generalGrp,
})

-- Git
local gitGrp = api.nvim_create_augroup('GitSettings', { clear = true })
api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'setlocal wrap',
  group = gitGrp,
})
api.nvim_create_autocmd('FileType', {
  pattern = { 'gitcommit' },
  command = 'setlocal spell',
  group = gitGrp,
})

-- Automatically compile latex script upon saving
local texGrp = api.nvim_create_augroup('TexSettings', { clear = true })
api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.tex' },
  command = 'silent! execute "!pdflatex -output-directory=%:p:h %:p > /dev/null 2>&1" | redraw!',
  group = texGrp,
})

-- Alpha
local alphaGrp = api.nvim_create_augroup('AlphaSettings', { clear = true })
api.nvim_create_autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2',
  group = alphaGrp,
})
api.nvim_create_autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set cul',
  group = alphaGrp,
})
api.nvim_create_autocmd('User', {
  pattern = { 'AlphaReady' },
  command = 'set norelativenumber',
  group = alphaGrp,
})

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

-- vim.cmd([[
--   augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
--     autocmd BufWinEnter * :set formatoptions-=cro
--     autocmd FileType qf set nobuflisted
--     autocmd WinEnter * set cul
--     autocmd WinLeave * set nocul
--     autocmd WinEnter * set relativenumber
--     autocmd WinLeave * set norelativenumber
--   augroup end
--
--   augroup _git
--     autocmd!
--     autocmd FileType gitcommit setlocal wrap
--     autocmd FileType gitcommit setlocal spell
--   augroup end
--
--   augroup _markdown
--     autocmd!
--     autocmd FileType markdown setlocal wrap
--     autocmd FileType markdown setlocal spell
--   augroup end
--
--   augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd =
--   augroup end
--
--  " Automatically compile latex script upon saving
--   augroup _tex
--     autocmd!
--     autocmd BufWritePost *.tex silent! execute "!pdflatex -output-directory=%:p:h %:p > /dev/null 2>&1" | redraw!
--   augroup END
--
--   augroup _alpha
--     autocmd!
--     autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--     autocmd User AlphaReady set cul
--     autocmd User AlphaReady set norelativenumber
--   augroup end
-- ]])
