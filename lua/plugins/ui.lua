return {

  {
    'akinsho/bufferline.nvim',
    lazy = false,
    opts = {
      options = {
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = true,
        offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'gruvbox',
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
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
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
    keys = { 'n', '<Leader>n', '<cmd>lua vim.notify.dismiss()<cr>', desc = 'Clear [N]otifications' },
    config = function()
      vim.notify = require('notify')
    end,
  },

  {
    'stevearc/dressing.nvim', -- Overwrites vim.ui.select
    lazy = true,
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
    keys = { '<Leader>si', '<cmd>IconPickerYank alt_font symbols nerd_font emoji<cr>', desc = '[S]earch [I]cons' },
  },

  {
    'goolord/alpha-nvim',
    lazy = false,
    config = function()
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
        dashboard.button('c', '  Configuration', ':e ~/.config/nvim/init.lua <CR>'),
        dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
      }

      dashboard.section.footer.val = 'Basically an IDE'

      dashboard.section.footer.opts.hl = 'Type'
      dashboard.section.header.opts.hl = 'Include'
      dashboard.section.buttons.opts.hl = 'Keyword'

      dashboard.opts.opts.noautocmd = true
      require('alpha').setup(dashboard.opts)
    end,
    keys = { '<Leader>a', '<cmd>Alpha<cr>', desc = 'Open [A]lpha' },
  },
}
