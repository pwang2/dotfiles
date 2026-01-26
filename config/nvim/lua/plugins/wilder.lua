return {
  "gelguy/wilder.nvim",
  enabled = false,
  build = ":UpdateRemotePlugins",
  event = "CmdLineEnter",
  config = function()
    local wilder = require("wilder")
    local highlights = require("config.highlights")
    wilder.setup({ modes = { ":", "/", "?" } })
    wilder.set_option("pipeline", {
      wilder.branch(
        -- enable type fuzzy file name when use :e xxx
        wilder.python_file_finder_pipeline({
          -- to use ripgrep : {'rg', '--files'}
          -- to use fd      : {'fd', '-tf'}
          file_command = { "find", ".", "-type", "f", "-printf", "%P\n" },
          -- to use fd      : {'fd', '-td'}
          dir_command = { "find", ".", "-type", "d", "-printf", "%P\n" },
          -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
          -- found at https://github.com/nixprime/cpsm
          filters = { "fuzzy_filter", "difflib_sorter" },
        }),

        wilder.cmdline_pipeline({
          -- sets the language to use, 'vim' and 'python' are supported
          language = "python",
          -- 0 turns off fuzzy matching
          -- 1 turns on fuzzy matching
          -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
          fuzzy = 2,
        }),
        --enable match wilder when use / ? search. can allow typo like missing characters
        --enable match wilder when use / ? search. can allow typo like missing characters
        wilder.python_search_pipeline({
          -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
          pattern = wilder.python_fuzzy_pattern(),
          -- omit to get results in the order they appear in the buffer
          sorter = wilder.python_difflib_sorter(),
          -- can be set to 're2' for performance, requires pyre2 to be installed
          -- see :h wilder#python_search() for more details
          engine = "re",
        })
      ),
    })
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        pumblend = 0,
        border = "rounded",
        highlighter = wilder.basic_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },
        highlights = {
          accent = wilder.make_hl(
            "WilderAccent",
            "Pmenu",
            { { a = 1 }, { foreground = 198, background = "NONE", bold = 0 }, { foreground = highlights.colors.wilder_foreground } }
          ),
        },
      }))
    )
  end,
}
