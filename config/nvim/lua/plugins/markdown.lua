return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && git clean -fd && git checkout . && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "codecompanion", "kulala_ui" }
    end,
    ft = { "markdown", "codecompanion" },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion", "kulala_ui" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      heading = {
        width = "block",
        left_pad = 2,
        right_pad = 2,
      },
      code = {
        left_pad = 2,
        enabled = true,
        style = "full", -- 'full' shows bg + language icon; 'normal' just does bg
        language = true,
        highlight = "RenderMarkdownCode",
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
