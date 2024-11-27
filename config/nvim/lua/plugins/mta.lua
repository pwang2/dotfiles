return {
  "valloric/MatchTagAlways",
  ft = { "html", "xml", "vue" },
  init = function()
    vim.g.mta_filetypes = { html = 1, xml = 1, vue = 1 }
  end,
}
