return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "codecompanion" }
    end,
    ft = { "markdown", "codecompanion" },
  },
  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   ft = { "markdown", "codecompanion" },
  --   config = function()
  --     vim.api.nvim_set_hl(0, "RenderMarkdownDash", { fg = "#282c34", bg = "#282c34" })
  --   end,
  -- },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
}
