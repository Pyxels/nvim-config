return {

  {
    'akinsho/bufferline.nvim',
    event = 'BufEnter',
    config = function()
      require('bufferline').setup{
        options = {
          diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
          diagnostics_update_in_insert = true,
          offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = 'thin',
          groups = {
            items = {
              require('bufferline.groups').builtin.pinned:with({ icon = "" })
            }
          }
        },
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'gruvbox',
        globalstatus = true,
        disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
      },
      sections = {
        lualine_a = {
          { 'branch', icons_enabled = true, icon = '' },
          {
            'diagnostics',
            sections = { 'error', 'warn' },
            symbols = { error = ' ', warn = ' ' },
            colored = false,
          },
        },
        lualine_b = {
          {
            'mode',
            fmt = function(str)
              if str == 'INSERT' then
                return '-- ' .. str .. ' --'
              end
              return '   ' .. str .. '   '
            end,
          },
        },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          {
            'diff',
            colored = false,
            symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
            cond = function()
              return vim.fn.winwidth(0) > 80
            end,
          },
          'encoding',
          'filetype',
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    main = 'ibl',
    opts = {
      exclude = {
        filetypes = {
          'help',
          'startify',
          'dashboard',
          'packer',
          'neogitstatus',
          'NvimTree',
          'Trouble',
          'UndoTree',
        },
      },
    },
  },

  {
    'rcarriga/nvim-notify', -- Notification popups
    lazy = false,
    keys = { { '<Leader>n', '<cmd>lua vim.notify.dismiss()<cr>', desc = 'Clear [N]otifications' } },
    config = function()
      vim.notify = require('notify')
    end,
  },

  {
    'stevearc/dressing.nvim', -- Overwrites vim.ui.select
    event = 'VeryLazy',
  },

  {
    'j-hui/fidget.nvim', -- fidget lsp progress
    tag = "legacy",
    opts = {
      text = {
        spinner = 'dots',
      },
    },
  },

  {
    'ziontee113/icon-picker.nvim',
    opts = {},
    keys = { { '<Leader>si', '<cmd>IconPickerYank alt_font symbols nerd_font emoji<cr>', desc = '[S]earch [I]cons' } },
  },

  {
    'goolord/alpha-nvim',
    lazy = false,
    dependencies = {
      'ahmedkhalf/project.nvim',
    },
    opts = function()
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[██████╗ ██╗   ██╗██╗  ██╗███████╗██╗     ███████╗]],
        [[██╔══██╗╚██╗ ██╔╝╚██╗██╔╝██╔════╝██║     ██╔════╝]],
        [[██████╔╝ ╚████╔╝  ╚███╔╝ █████╗  ██║     ███████╗]],
        [[██╔═══╝   ╚██╔╝   ██╔██╗ ██╔══╝  ██║     ╚════██║]],
        [[██║        ██║   ██╔╝ ██╗███████╗███████╗███████║]],
        [[╚═╝        ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝]],
        [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
        [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', '󰈞  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('p', '  Find project', ':Telescope projects <CR>'),
        dashboard.button('r', '󰄉  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('w', '󰗚 Vim Wiki', ':VimwikiIndex <CR>'),
        dashboard.button('t', '󰊄  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('l', '󰒲' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', '󰅚  Quit Neovim', ':qa<CR>'),
      }

      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'Include'
      dashboard.section.buttons.opts.hl = 'Keyword'

      dashboard.opts.opts.noautocmd = true
      return dashboard
    end,
    config = function(_, dashboard)
      vim.b.miniindentscope_disable = true

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function()
            require('lazy').show()
          end,
        })
      end

      require('alpha').setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
    keys = { { '<Leader>a', '<cmd>Alpha<cr>', desc = 'Open [A]lpha' } },
  },
}
