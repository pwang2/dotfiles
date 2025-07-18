return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && git clean -fd && git checkout . && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "codecompanion" }
    end,
    ft = { "markdown", "codecompanion" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    opts = {
      code = {
        left_pad = 2,
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    enabled = false,
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
}
