return {
  "Davidyz/VectorCode",
  enabled = false,
  version = "*",
  lazy = true,
  cmd = { "VectorCode" },
  build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
  dependencies = { "nvim-lua/plenary.nvim" },
  init = function()
    require("codecompanion").setup({
      extensions = {
        vectorcode = {
          enabled = true,
          opts = {
            add_tool = true,
            add_slash_command = true,
            tool_opts = {},
          },
        },
      },
    })
  end,
}
