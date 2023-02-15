return {

  'kyazdani42/nvim-web-devicons',

  {
    'nvim-tree/nvim-tree.lua',
    lazy = true,
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    keys = { { '<Leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTr[e]e' } },
    opts = {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      disable_netrw = true,
      ignore_ft_on_setup = {
        'startify',
        'dashboard',
        'alpha',
      },
      renderer = {
        icons = {
          glyphs = {
            default = '',
            symlink = '',
            git = {
              unstaged = '',
              staged = '',
              unmerged = '',
              renamed = '',
              deleted = '',
              untracked = '',
              ignored = '◌',
            },
            folder = {
              default = '',
              open = '',
              empty = '',
              empty_open = '',
              symlink = '',
            },
          },
        },
      },
    },
  },

  { -- undo tree for non linear history
    'mbbill/undotree',
    keys = { { '<Leader>u', '<cmd>UndotreeToggle <cr>', desc = 'Toggle [U]ndoTree' } },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    keys = {
      { '<Leader>gj', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = '[G]it: Next Hunk' },
      { '<Leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = '[G]it: Prev Hunk' },
      { '<Leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk_inline()<cr>", desc = '[G]it: [P]review Hunk' },
      { '<Leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = '[G]it: [R]eset Hunk' },
      { '<Leader>gR', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = '[G]it: [R]eset Buffer' },
      { '<Leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = '[G]it: [S]tage Hunk' },
      { '<Leader>gu', "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = '[G]it: [U]ndo Stage Hunk' },
      { '<Leader>gd', "<cmd>lua require 'gitsigns'.diffthis()<cr>", desc = '[G]it: [D]iff this buffer' },
    },
    opts = {
      signs = {
        add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
    },
  },

  {
    'ahmedkhalf/project.nvim',
    lazy = false,
    config = function()
      require('project_nvim').setup({
        detection_methods = { 'pattern' },
      })
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    dependencies = {
      'ahmedkhalf/project.nvim',
    },
    cmd = 'Telescope',
    keys = {
      {
        '<Leader>b',
        "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = 'Telescope [B]uffers',
      },
      {
        '<Leader>f',
        "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        desc = '[F]ind files',
      },
      { '<Leader>F', '<cmd>Telescope live_grep theme=ivy<cr>', desc = '[F]ind Text' },
      { '<Leader>P', "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = '[P]rojects' },
      { '<Leader>sb', '<cmd>Telescope git_branches<cr>', desc = '[S]earch [B]ranches' },
      { '<Leader>sC', '<cmd>Telescope colorscheme<cr>', desc = '[S]earch [C]olorschemes' },
      { '<Leader>sh', '<cmd>Telescope help_tags<cr>', desc = '[S]earch [H]elp' },
      { '<Leader>sM', '<cmd>Telescope man_pages<cr>', desc = '[S]earch [M]an Pages' },
      { '<Leader>sr', '<cmd>Telescope oldfiles<cr>', desc = '[S]earch [R]ecent Files' },
      { '<Leader>sR', '<cmd>Telescope registers<cr>', desc = '[S]earch [R]egisters' },
      { '<Leader>sk', '<cmd>Telescope keymaps<cr>', desc = '[S]earch [K]eymaps' },
      { '<Leader>sc', '<cmd>Telescope commands<cr>', desc = '[S]earch [C]ommands' },
    },
    config = function()
      local telescope = require('telescope')
      return {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
        },
        extensions = {
          telescope.load_extension('notify'),
          telescope.load_extension('projects'),
        },
      }
    end,
  },
}
