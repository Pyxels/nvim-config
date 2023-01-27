return {

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
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
            always_visible = true,
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
          {
            'filetype',
            icons_enabled = true,
            icon = nil,
          },
        },
        lualine_y = { {
          'location',
          padding = 0,
        } },
        lualine_z = {
          function()
            local current_line = vim.fn.line('.')
            local total_lines = vim.fn.line('$')
            local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
          end,
        },
      },
      tabline = {
        lualine_a = { { 'buffers', symbols = { alternate_file = '' } } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'tabs' },
      },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    opts = {
      show_current_context = true,
      use_treesitter = true,
      show_trailing_blankline_indent = false,
      filetype_exclude = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'UndoTree',
      },
      context_patterns = {
        'class',
        'return',
        'function',
        'method',
        '^if',
        '^while',
        'jsx_element',
        '^for',
        '^object',
        '^table',
        'block',
        'arguments',
        'if_statement',
        'else_clause',
        'jsx_element',
        'jsx_self_closing_element',
        'try_statement',
        'catch_clause',
        'import_statement',
        'operation_type',
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
    lazy = true,
    opts = {
      text = {
        spinner = 'dots',
      },
    },
  },

  {
    'ziontee113/icon-picker.nvim',
    lazy = true,
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
        dashboard.button('f', '  Find file', ':Telescope find_files <CR>'),
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('p', '  Find project', ':Telescope projects <CR>'),
        dashboard.button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        dashboard.button('w', '龎 Vim Wiki', ':VimwikiIndex <CR>'),
        dashboard.button('t', '  Find text', ':Telescope live_grep <CR>'),
        dashboard.button('c', '  Configuration', ':e $MYVIMRC <CR>'),
        dashboard.button('l', '鈴' .. ' Lazy', ':Lazy<CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
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
