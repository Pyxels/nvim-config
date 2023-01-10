return {
  { -- The completion plugin
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = function()
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if not cmp_status_ok then
        return
      end

      local snip_status_ok, luasnip = pcall(require, 'luasnip')
      if not snip_status_ok then
        return
      end

      local select_choice = require('luasnip.extras.select_choice')

      --   פּ ﯟ   some other good icons
      local kind_icons = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
      }
      -- find more here: https://www.nerdfonts.com/cheat-sheet

      local custom_colors = {}

      local custom_mapping = {
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.mapping(
          cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          { 'i', 'c' }
        ),
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ['<C-l>'] = cmp.mapping(function()
          luasnip.jump(1)
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          luasnip.jump(-1)
        end, { 'i', 's' }),
        ['<A-l>'] = cmp.mapping(function()
          luasnip.change_choice(1)
        end, { 'i', 's' }),
        ['<A-h>'] = cmp.mapping(function()
          luasnip.change_choice(-1)
        end, { 'i', 's' }),
        ['<C-c>'] = cmp.mapping(function()
          if luasnip.choice_active() then
            select_choice()
          end
        end, { 'i', 's' }),
      }

      local custom_formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
          -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          vim_item.menu = ({
            nvim_lsp = '[LSP]',
            crates = '[Crates]',
            luasnip = '[Snippet]',
            buffer = '[Buffer]',
            path = '[Path]',
          })[entry.source.name]

          if custom_colors[entry.source.name] then
            vim_item.kind_hl_group = custom_colors[entry.source.name]
          end

          return vim_item
        end,
      }

      local custom_sources = {
        { name = 'nvim_lsp' },
        { name = 'crates' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = custom_mapping,
        formatting = custom_formatting,
        sources = custom_sources,
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        preselect = cmp.PreselectMode.None,
        window = {
          documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          },
        },
        experimental = {
          ghost_text = false,
          native_menu = false,
        },
      }
    end,
  },
}
