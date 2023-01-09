local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use('wbthomason/packer.nvim') -- Have packer manage itself
  use('nvim-lua/plenary.nvim') -- Useful lua functions used in lots of plugins
  use('numToStr/Comment.nvim') -- Easily comment stuff
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')
  use('akinsho/bufferline.nvim')
  use('moll/vim-bbye') -- close buffers without messing up layout
  use('nvim-lualine/lualine.nvim')
  use('ahmedkhalf/project.nvim')
  use('lewis6991/impatient.nvim')
  use('lukas-reineke/indent-blankline.nvim')
  use('goolord/alpha-nvim')
  use('rcarriga/nvim-notify') -- Notification popups
  use('stevearc/dressing.nvim') -- Overwrites vim.ui.select
  use('vimwiki/vimwiki') -- Vim Wiki
  use('wakatime/vim-wakatime') -- Code time usage
  use('j-hui/fidget.nvim') -- fidget lsp progress
  use('mbbill/undotree') -- undo tree for non linear history
  use('kylechui/nvim-surround') -- surround text objects with ( { " ....

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  -- use "ellisonleao/gruvbox.nvim"
  -- use("lifepillar/vim-gruvbox8")
  use('luisiacc/gruvbox-baby')
  -- use "lunarvim/darkplus.nvim"
  use('norcalli/nvim-colorizer.lua')

  -- cmp plugins
  use('hrsh7th/nvim-cmp') -- The completion plugin
  use('hrsh7th/cmp-buffer') -- buffer completions
  use('hrsh7th/cmp-path') -- path completions
  use('hrsh7th/cmp-cmdline') -- cmdline completions
  use('saadparwaiz1/cmp_luasnip') -- snippet completions
  use('hrsh7th/cmp-nvim-lsp')
  use({ -- Crates for Rust
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  })
  use('simrat39/rust-tools.nvim')

  -- snippets
  use('L3MON4D3/LuaSnip') --snippet engine
  use('rafamadriz/friendly-snippets') -- a bunch of snippets to use

  -- LSP
  use('neovim/nvim-lspconfig') -- enable LSP
  use('williamboman/mason.nvim')
  use('williamboman/mason-lspconfig.nvim')
  use('tamago324/nlsp-settings.nvim') -- language server settings defined in json for
  use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters
  use('gpanders/editorconfig.nvim') -- editorconfig for fomatting
  use('elkowar/yuck.vim') -- filetype support for eww configuration language
  use('ron-rs/ron.vim') -- filetype support for rust object notation (rom) language

  -- Telescope
  use('nvim-telescope/telescope.nvim')

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })
  use('JoosepAlviste/nvim-ts-context-commentstring')

  -- Git
  use('lewis6991/gitsigns.nvim')

  -- Icons
  use({
    'ziontee113/icon-picker.nvim',
    config = function()
      require('icon-picker').setup({
        disable_legacy_commands = true,
      })
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
