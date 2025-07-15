return {
  "numToStr/Comment.nvim",
  event = "BufReadPost",
  dependencies = {
    -- This plugin provides context-aware commenting functionality in vue file
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
    vim.keymap.del("n", "gc")
    vim.keymap.del("n", "gb")
    local wk = require("which-key")
    wk.add({
      { "gb", group = "Comment toggle blockwise" },
      { "gc", group = "Comment toggle linewise" },
    })
  end,
}
