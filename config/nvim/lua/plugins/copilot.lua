return {
  "github/copilot.vim",
  enabled = false,

  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
  end,
}
