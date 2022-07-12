local ls = require('luasnip')

require('luasnip/loaders/from_vscode').lazy_load()

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.config.set_config({
  history = true,
  -- treesitter-hl has 100, use something higher (default is 200).
  ext_base_prio = 200,
  -- minimal increase in priority.
  ext_prio_increase = 1,
  enable_autosnippets = false,
  store_selection_keys = '<c-s>',
})

ls.add_snippets(nil, {
  -- LaTex snippets
  tex = {
    snip({
      trig = 'quote',
      namr = 'Quote',
      dscr = 'German style double quote',
    }, {
      text('\\glqq '),
      insert(1, 'quote'),
      text('\\grqq{} '),
      insert(0),
    }),
    snip({
      trig = 'inlinecode',
      namr = 'Inline Code',
      dscr = 'Inline code with german quotes',
    }, {
      text('\\glqq \\mintinline{'),
      insert(1, 'language'),
      text('}|'),
      insert(2, 'code'),
      text('|\\grqq{} '),
      insert(0),
    }),
  },
})

-- show inlay hint when having a choice or inserting
-- Question and Directory are hightlight groups and fit my current color scheme
local types = require('luasnip.util.types')
require('luasnip').config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '', 'Question' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '', 'Directory' } },
      },
    },
  },
})
