return {
  'rafamadriz/friendly-snippets', -- a bunch of snippets to use
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets', -- a bunch of snippets to use
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
    config = function()
      local ls = require('luasnip')
      -- some shorthands...
      local snip = ls.snippet
      local node = ls.snippet_node
      local text = ls.text_node
      local insert = ls.insert_node

      local func = ls.function_node
      local choice = ls.choice_node
      local dynamicn = ls.dynamic_node

      local fmt = require('luasnip.extras.fmt').fmt

      ls.add_snippets(nil, {
        -- LaTex snippets
        tex = {
          snip(
            {
              trig = 'quote',
              namr = 'Quote',
              dscr = 'German style double quote',
            },
            fmt([[ \glqq <>\grqq{}<>]], {
              insert(1, 'quote'),
              insert(0),
            }, { delimiters = '<>' })
          ),
          snip(
            {
              trig = 'inlinecode',
              namr = 'Inline Code',
              dscr = 'Inline code with german quotes (needs new command)',
            },
            fmt([[ \inlinecode{<>}{<>}<>]], {
              choice(1, { insert(nil, 'language'), text('sh'), text('Dockerfile') }),
              insert(2, 'code'),
              insert(0),
            }, { delimiters = '<>' })
          ),
          snip(
            {
              trig = 'mintedcode',
              namr = 'Minted Code',
              dscr = 'Minted code block with listing surrounding',
            },
            fmt(
              [[
\begin{listing}[h!]
  \begin{minted}{<>}
<>
  \end{minted}
  \caption{<>}
  \label{lis:<>}
\end{listing}
<>]],
              {
                choice(1, { insert(nil, 'language'), text('sh'), text('Dockerfile') }),
                insert(2, 'code'),
                insert(3, 'caption'),
                insert(4, 'label'),
                insert(0),
              },
              { delimiters = '<>' }
            )
          ),
          snip(
            {
              trig = 'figure',
              namr = 'Figure',
              dscr = 'Figure with caption and label',
            },
            fmt(
              [[
\begin{figure}<>
  \centering
  \includegraphics[width=<>\textwidth]{<>}
  \caption{<>}
  \label{fig:<>}
\end{figure}
<>]],
              {
                choice(1, { insert(nil), node(nil, { text('['), insert(1), text(']') }) }),
                insert(2, 'width'),
                insert(3, 'path'),
                insert(4, 'caption'),
                insert(5, 'label'),
                insert(0),
              },
              { delimiters = '<>' }
            )
          ),
        },
      })

      local types = require('luasnip.util.types')
      require('luasnip').config.setup({
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { '', 'GruvboxOrange' } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { '', 'GruvboxBlue' } },
            },
          },
        },
      })
    end,
  }, --snippet engine
}
